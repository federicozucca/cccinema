require('pry-byebug')
require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')


Customer.delete_all
Film.delete_all
Ticket.delete_all

customer1 = Customer.new({
  'name' => 'Federico',
  'funds' => 50
  })

customer2 = Customer.new({
  'name' => 'Enrico',
  'funds' => 80
  })

customer3 = Customer.new({
  'name' => 'Giulia',
  'funds' => 100
  })

customer4 = Customer.new({
  'name' => 'Zoe',
  'funds' => 20
  })


customer4.name = "Pippi"
# customer4.update()
customer1.save()
customer2.save()
customer3.save()
customer4.save()

film1 = Film.new({
  'title' => 'The patriot',
  'price' => 10
  })

film2 = Film.new({
  'title' => 'Star Wars',
  'price' => 15
  })

film3 = Film.new({
  'title' => 'The gladiator',
  'price' => 10
  })

film4 = Film.new({
  'title' => 'The green mile',
  'price' => 10
  })

film1.save
film2.save
film3.save
film4.save


ticket1 = Ticket.new({ 
  'customer_id' => customer1.id, 
  'film_id' => film1.id,
  'film_time'=>'19:00'})

ticket2 = Ticket.new({ 
  'customer_id' => customer2.id, 
  'film_id' => film1.id, 
  'film_time'=>'20:00'})

ticket3 = Ticket.new({ 
  'customer_id' => customer3.id, 
  'film_id' => film1.id, 
  'film_time'=>'21:30'})

ticket4 = Ticket.new({ 
  'customer_id' => customer4.id, 
  'film_id' => film1.id,
  'film_time'=> '21:00'})

ticket5 = Ticket.new({ 
  'customer_id' => customer2.id, 
  'film_id' => film1.id,
  'film_time'=> '19:00'})

ticket1.save()
ticket2.save()
ticket3.save()
ticket4.save()
ticket5.save()

# customer1.decrease_funds(film1)

Ticket.issue_ticket(customer1,film1,'21:00')

binding.pry
nil