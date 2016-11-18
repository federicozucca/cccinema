require('pry-byebug')
require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')

Customer.delete_all

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

ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id})


binding.pry
nil