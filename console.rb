require('pry-byebug')
require_relative('models/customers.rb')
require_relative('models/films.rb')
# require_relative('models/tickets.rb')

# Ticket.delete_all()
# Film.delete_all()
Customer.delete_all()

customer1 = Customer.new({'name' => 'Mark Blanford', 'funds' => 35})
customer1.save()

film1 = Film.new({'title' => 'Let The Right One In', 'price' => 8})
film1.save()

customer_list = Customer.all()


binding.pry
nil
