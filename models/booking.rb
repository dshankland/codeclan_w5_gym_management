require_relative('../db/sql_runner.rb')

class Booking

  attr_reader :id, :member_id, :gymclass_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @member_id = options['member_id'].to_i
    @gymclass_id = options['gymclass_id'].to_i
  end

  def save()
    sql = 'INSERT INTO bookings (member_id, gymclass_id) VALUES ($1, $2) RETURNING id'
    values = [@member_id,@gymclass_id]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql = 'SELECT * FROM bookings'
    results = SqlRunner.run( sql )
    return results.map {|booking| Booking.new(booking)}
  end

  def update()
    sql = 'UPDATE bookings SET (member_id, gymclass_id) = ($1, $2) WHERE id = $3'
    values = [@member_id,@gymclass_id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = 'SELECT * FROM bookings WHERE id = $1'
    values = [id]
    results = SqlRunner.run(sql, values)
    return Booking.new(results.first)
  end

  def self.delete_all()
    sql = 'DELETE FROM bookings'
    SqlRunner.run(sql)
  end

  def self.delete(id)
    sql = 'DELETE FROM bookings WHERE id = $1'
    values = [id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM bookings WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  # def self.remove(options)
  #   member_id = options['member_id'].to_i
  #   gymclass_id = options['gymclass_id'].to_i
  #   sql = 'DELETE FROM bookings WHERE gymclass_id = $1 AND member_id = $2'
  #   values = [member_id, gymclass_id]
  #   SqlRunner.run(sql, values)
  # end

  # member_name returns the member name for the booking. Useful for displaying members booked into a class
  def member_name()
    sql = "SELECT members.name FROM members INNER JOIN bookings ON bookings.member_id = members.id WHERE bookings.id = $1;"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.first()['name']
  end

end