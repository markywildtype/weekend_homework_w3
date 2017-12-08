require_relative('../db/sql_runner')

class Ticket

  attr_reader :id, :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id)
    VALUES ($1, $2)
    RETURNING id;"
    values = [@customer_id, @film_id]
    ticket_hash_array = SqlRunner.run(sql, values)
    @id = ticket_hash_array[0]['id']
  end

  def self.all()
    sql = "SELECT * FROM tickets;"
    all_tickets_hashes = SqlRunner.run(sql)
    all_tickets = all_tickets_hashes.map {|ticket_hash| Ticket.new(ticket_hash)}
    return all_tickets
  end

  def self.delete_all()
    sql = "DELETE FROM tickets;"
    SqlRunner.run(sql)
  end


end
