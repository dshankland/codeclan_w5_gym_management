require('pg')

class SqlRunner

  def self.run(sql, values = [])
    begin
      # db = PG.connect({dbname: 'gym4all', host: 'localhost'})
      db = PG.connect({dbname: 'dbonoqtrabskk7', host: 'ec2-54-197-239-115.compute-1.amazonaws.com', port: 5432, user: 'oofurhuhshhzyy', password: '66b416def0d6b0d2e632313c5bd8a3167d589c6d02dfb438a4d71c9b1ba2d94e'})
      db.prepare('query', sql)
      result = db.exec_prepared('query', values)
    ensure
      db.close() if db != nil
    end
    return result
  end

end
