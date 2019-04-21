require('pg')

class SqlRunner

  def self.run(sql, values = [])
    begin
      # db = PG.connect({dbname: 'gym4all', host: 'localhost'})
      db = PG.connect({dbname: 'd4pjooq5hhdpu0', host: 'ec2-50-17-231-192.compute-1.amazonaws.com', port: 5432, user: 'ibmktlmxbowdxg', password: 'ddd467ab38a38877cedca7e8b4f6299442d0b4d66f92953247f2dd2600a018c8'})
      db.prepare('query', sql)
      result = db.exec_prepared('query', values)
    ensure
      db.close() if db != nil
    end
    return result
  end

end
