require_relative('../db/sql_runner.rb')
require_relative('booking.rb')
require_relative('member.rb')
require('time')

class GymClass

  attr_reader :id, :name, :time, :spaces

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @time = to_time(options['time'])
    @spaces = options['spaces'].to_i
  end

  def to_time(param)
    return param if param.is_a?(Time)
    return Time.parse(param)
  end

  def save()
    sql = 'INSERT INTO gymclasses (name, time, spaces) VALUES ($1, $2, $3) RETURNING id'
    values = [@name, @time, @spaces]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql = 'SELECT * FROM gymclasses'
    results = SqlRunner.run( sql )
    return results.map {|gymclass| GymClass.new(gymclass)}
  end

  def update()
    sql = 'UPDATE gymclasses SET (name, time, spaces) = ($1, $2, $3) WHERE id = $4'
    values = [@name,@time,@spaces,@id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM gymclasses WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = 'DELETE FROM gymclasses'
    SqlRunner.run(sql)
  end

  def self.delete(id)
    sql = 'DELETE FROM gymclasses WHERE id = $1'
    values = [id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = 'SELECT * FROM gymclasses WHERE id = $1'
    values = [id]
    results = SqlRunner.run(sql, values)
    return GymClass.new(results.first)
  end

  def members()
    sql = "SELECT members.* FROM members INNER JOIN bookings ON bookings.member_id = members.id WHERE bookings.gymclass_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map {|member| Member.new(member)}
  end

  def bookings()
    sql = "SELECT * FROM bookings WHERE bookings.gymclass_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map {|booking| Booking.new(booking)}
  end

  def available_members()
    # add some logic in here to check whether the class is peak, and only supply a list
    # of premium members
    # sql = "SELECT members.* FROM members;"
    # also want to check to see if there are available spaces for the class, if noit - return an empty array
    if @spaces > 0
      if is_peak()
        sql = "SELECT * from members WHERE id NOT IN (SELECT member_id FROM bookings WHERE gymclass_id = $1) AND premium = TRUE;"
      else
        sql = "SELECT * from members WHERE id NOT IN (SELECT member_id FROM bookings WHERE gymclass_id = $1);"
      end
      values = [@id]
      results = SqlRunner.run(sql, values)
      return results.map {|member| Member.new(member)}
    else
      return []
    end
  end

  def decrease_spaces()
    @spaces -= 1
  end

  def increase_spaces()
    @spaces += 1
  end

  def is_peak()
    @time.hour.between?(7,8) || @time.hour.between?(17,19)
  end

  # trying to write a function that will bring back a specific days
  # gym class schedule, to aid building a schedule page
  # takes a parameter of days, 0 will return today, 1 tomorrow, etc..
  # bodged this to run using interpolation as values is not being detected for some reason
  def self.date_range(days)
    sql = "SELECT * FROM gymclasses WHERE DATE_TRUNC('day',time) = CURRENT_DATE + interval '#{days} day' ORDER BY time"
    values = [days]
    results = SqlRunner.run(sql)
    return results.map {|gymclass| GymClass.new(gymclass)}
  end

  # def add_member(member_id)
  #   Booking.new({'member_id' => member_id, 'gymclass_id' => @id}).save()
  # end

  # def add_members(member_ids)
  #   member_ids.each {|member_id| Booking.new({'member_id' => member_id, 'gymclass_id' => @id}).save()}
  # end

end