require('pg')
require('pry-byebug')
require_relative("../db/sql_runner")
require_relative('customer')
require_relative('ticket')

class Ticket

  attr_reader :id
  attr_accessor :film_id, :customer_id, :film_time

  def initialize( options )
    @id = options['id'].to_i
    @film_id = options['film_id']
    @customer_id = options['customer_id']
    @film_time = options['film_time']
  end

  def save()
    sql = "INSERT INTO tickets (film_id , customer_id, film_time ) VALUES ('#{ @film_id }', #{@customer_id}, '#{film_time}') RETURNING id"
    ticket = SqlRunner.run( sql ).first
    @id = ticket['id'].to_i
  end

  def delete
    return unless @id
    sql = "DELETE FROM tickets WHERE id = '#{@id}'"
    result = SqlRunner.run( sql )
  end

  def update
    sql = "UPDATE tickets SET (title) = ('#{@title}') WHERE id = (#{@id})"
    result = SqlRunner.run( sql )
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    ticket = SqlRunner.run(sql)
    result = ticket.map { ticket| Customer.new( ticket ) }
    return result
  end

  def self.delete_all() 
    sql = "DELETE FROM tickets"
    ticket = SqlRunner.run(sql)
    result = ticket.map { ticket| Customer.new( ticket ) }
    return result
  end

  def most_popular_time()
    sql = "SELECT film_time FROM tickets WHERE film_id = #{@id};"
    result = SqlRunner.run(sql)
    tickets_array = result.map{|ticket| Ticket.new(ticket)}
    time_array = tickets_array{|ticket| ticket.film_time}



  end

  def self.issue_ticket(customer,film, film_time)
    customer.decrease_funds(film)
    ticket = Ticket.new({"customer_id" => customer.id,"film_id" => film.id, "film_time" => film_time})
    ticket.save()
    return ticket
  end
  
end