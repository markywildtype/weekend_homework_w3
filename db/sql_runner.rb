require('pg')

class SqlRunner

  def self.run()
    begin
      db = PG.connect( {dbname: cinema, host: localhost} )
      db.prepare('query', sql)
      result = db.exec_prepared('query', values)
    ensure
      db.close()
    end
    return result
  end

end
