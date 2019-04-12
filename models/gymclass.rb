require_relative('../db/sql_runner.rb')
require('time')

class GymClass

  attr_reader :id, :name, :time, :spaces

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @time = to_time(options['time'])
    @spaces = options['spaces']
  end

  def to_time(param)
    return param if param.is_a?(Time)
    return Time.parse(param)
  end

  def save()
    sql = "INSERT INTO gymclasses (name, time, spaces) VALUES ($1, $2, $3) RETURNING id"
    values = [@name, @time, @spaces]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM gymclasses"
    results = SqlRunner.run( sql )
    return results.map {|gymclass| GymClass.new(gymclass)}
  end

  def update()
    sql = "UPDATE gymclasses SET (name, time, spaces) = ($1, $2, $3) WHERE id = $4"
    values = [@name,@time,@spaces]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM gymclasses"
    SqlRunner.run(sql)
  end

  def self.delete(id)
    sql = "DELETE FROM gymclasses WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end

end