require_relative('../db/sql_runner.rb')

class Film

  def initialize(options)
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films (title, price)
    VALUES ($1, $2)
    RETURNING id;"
    values = [@title, @price]
    film_hashes_array = SqlRunner.run(sql, values)
    @id = film_hashes_array[0]['id']
  end

end
