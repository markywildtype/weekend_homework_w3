require_relative('../db/sql_runner.rb')
require_relative('customers.rb')

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

  def update()
    sql = "UPDATE films SET (title, price)
    = ($1, $2)
    WHERE id = $3;"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM films
    WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT customers.name FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customers.id
    WHERE tickets.film_id = $1;"
    values = [@id]
    customer_array = SqlRunner.run(sql, values)
    customers = customer_array.map {|customer| Customer.new(customer).name}
    return customers
  end

  def number_of_customers()
    return customers().length()
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
