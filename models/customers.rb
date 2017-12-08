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

end
