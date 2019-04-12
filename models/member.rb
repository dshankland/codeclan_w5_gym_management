require_relative('../db/sql_runner.rb')

class Member

  attr_reader :id, :name, :premium

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @premium = to_bool(options['premium'])
  end

  def to_bool(param)
    return true if (param == true || param == 't')
    return false
  end

  def save()
    sql = 'INSERT INTO members (name, premium) VALUES ($1, $2) RETURNING id'
    values = [@name, @premium]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql = 'SELECT * FROM members'
    results = SqlRunner.run( sql )
    return results.map {|member| Member.new(member)}
  end

  def update()
    sql = 'UPDATE members SET (name, premium) = ($1, $2) WHERE id = $3'
    values = [@name,@premium]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = 'DELETE FROM members'
    SqlRunner.run(sql)
  end

  def self.delete(id)
    sql = 'DELETE FROM members WHERE id = $1'
    values = [id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = 'SELECT * FROM members WHERE id = $1'
    values = [id]
    results = SqlRunner.run(sql, values)
    return Member.new(results.first)
  end

  def gymclasses()
    sql = "SELECT gymclasses.* FROM gymclasses INNER JOIN bookings ON bookings.gymclass_id = gymclasses.id WHERE bookings.member_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map {|gymclass| GymClass.new(gymclass)}
  end

end