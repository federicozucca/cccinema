require('pg')
require('pry-byebug')
require_relative("../db/sql_runner")
require_relative('customer')
require_relative('ticket')

class Ticket

  attr_reader :id
  attr_accessor :film_id, :customer_id 

  def initialize( options )
    @id = options['id'].to_i
    @film_id = options['film_id']
    @customer_id = options['customer_id']
  end

  def save()
    sql = "INSERT INTO tickets (film_id , customer_id) VALUES ('#{ @film_id }', #{@customer_id}) RETURNING id"
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

  def issue_tickets(customer_id,film_id)
    @customer_id.decrese_funds(film_id.price)
    ticket = Ticket.new(customer_id,film_id)
    ticket.save()
    return ticket
  end
  
end