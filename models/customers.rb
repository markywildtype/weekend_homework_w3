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
