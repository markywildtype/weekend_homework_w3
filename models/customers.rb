require_relative('../db/sql_runner.rb')
require_relative('films.rb')
require('pry-byebug')

class Customer

  attr_accessor :name, :funds
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers (name, funds)
    VALUES ($1, $2)
    RETURNING id;"
    values = [@name, @funds]
    customer_hash_array = SqlRunner.run(sql, values)
    @id = customer_hash_array[0]['id'].to_i
  end

  def update()
    sql = "UPDATE customers SET (name, funds)
    = ($1, $2)
    WHERE id = $3;"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM customers
    WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT DISTINCT films.title FROM films
    INNER JOIN tickets
    ON tickets.film_id = films.id
    WHERE tickets.customer_id = $1;"
    values = [@id]
    film_array = SqlRunner.run(sql, values)
    films = film_array.map {|film| Film.new(film).title}
    return films
  end

  def buy_ticket(film)
    @funds -= film.price
    sql = "INSERT INTO tickets (customer_id, film_id)
    VALUES ($1, $2);"
    values = [@id, film.id()]
    bought_ticket = SqlRunner.run(sql, values)
    new_ticket = bought_ticket.map {|ticket| Ticket.new(ticket)}
    update()
  end

  def number_of_tickets()
    return films().length()
  end

  def self.all()
    sql = "SELECT * FROM customers;"
    all_customers_hashes = SqlRunner.run(sql)
    all_customers = all_customers_hashes.map() { |customer_hash| Customer.new(customer_hash)}
    return all_customers
  end

  def self.delete_all()
    sql = "DELETE FROM customers;"
    SqlRunner.run(sql)
  end

end
