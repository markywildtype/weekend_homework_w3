require_relative('../db/sql_runner.rb')

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

  def update_name(new_name)
    sql = "UPDATE customers SET name = $1 WHERE name = $2"
    values = [new_name, @name]
    SqlRunner.run(sql, values)
  end

  def remove_funds(amount)
    @funds -= amount
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
