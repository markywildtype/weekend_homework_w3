require('pry-byebug')
require_relative('models/customers.rb')
require_relative('models/films.rb')
require_relative('models/tickets.rb')

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

customer1 = Customer.new({'name' => 'Mark Blanford', 'funds' => 35})
customer1.save()
customer2 = Customer.new({'name' => 'Aline Nardo', 'funds' => 83})
customer2.save()
customer3 = Customer.new({'name' => 'Ciaran McKenna', 'funds' => 50})
customer3.save()

film1 = Film.new({'title' => 'Let The Right One In', 'price' => 8})
film1.save()
film2 = Film.new({'title' => 'Ghostbusters', 'price' => 5})
film2.save()
film3 = Film.new({'title' => 'Predator', "price" => 4})
film3.save()

# ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
# ticket1.save()
# ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film1.id})
# ticket2.save()
# ticket3 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film2.id})
# ticket3.save()


customer1.name = 'Mark E Blanford'
customer1.funds = 55
customer1.update

film1.title = 'Let Me In'
film1.price = 6
film1.update()


customer_list = Customer.all()
film_list = Film.all()
ticket_list = Ticket.all()

# customer2.delete()
# film2.delete()
# ticket1.delete()

# customer1.remove_funds(8)
# customer_funds = customer1.funds()

customer1.buy_ticket(film1)
customer2.buy_ticket(film1)
customer1.buy_ticket(film2)
customer1.buy_ticket(film3)
customer3.buy_ticket(film3)


updated_customer_list = Customer.all()
updated_film_list = Film.all()
updated_ticket_list = Ticket.all()
customer_films = customer3.films()
film1_customers = film1.customers()
film3_customers = film3.customers()
number_tickets_bought = customer1.number_of_tickets()

binding.pry
nil
