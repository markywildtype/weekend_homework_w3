require_relative('../db/sql_runner.rb')

class Film

  attr_accessor :title, :price
  attr_reader :id

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

  def self.all()
    sql = "SELECT * FROM films;"
    all_films_hashes = SqlRunner.run(sql)
    all_films = all_films_hashes.map { |film_hash| Film.new(film_hash)}
    return all_films
  end

  def self.delete_all()
    sql = "DELETE FROM films;"
    SqlRunner.run(sql)
  end

end
