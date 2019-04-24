require('pg')

class SqlRunner

  def self.run(sql, values = [])
    begin
      db = PG.connect({dbname: 'gym4all', host: 'localhost'})
      # db = PG.connect({dbname: 'd2pq0rcjqkolca', host: 'ec2-54-225-129-101.compute-1.amazonaws.com', port: 5432, user: 'ahcefxzxiqkfen', password: '321a9ee536d4bc613179217b53861608e3c8cb89a9ed58df20612ee15685ab70'})
      db.prepare('query', sql)
      result = db.exec_prepared('query', values)
    ensure
      db.close() if db != nil
    end
    return result
  end

end
