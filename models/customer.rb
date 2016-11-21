require('pg')
require('pry-byebug')
require_relative("../db/sql_runner")
require_relative('ticket')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize( options )
    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds']
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ('#{ @name }', #{@funds}) RETURNING id"
    customer = SqlRunner.run( sql ).first
    @id = customer['id'].to_i
  end

  def delete
    return unless @id
    sql = "DELETE FROM customers WHERE id = '#{@id}'"
    result = SqlRunner.run( sql )
  end

  def update()
    sql = "UPDATE customers SET (name) = ('#{@name}') WHERE id = (#{@id})"
    result = SqlRunner.run( sql )
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customer = SqlRunner.run(sql)
    result = customer.map { customer| Customer.new(customer ) }
    return result
  end

  def self.delete_all() 
    sql = "DELETE FROM customers"
    customer = SqlRunner.run(sql)
    result = customer.map { customer| Customer.new(customer ) }
    return result
  end

  def decrease_funds(film)
    @funds = @funds - film.price
    update()
  end

  def number_of_tickets()
    sql = "SELECT count(customer_id) FROM tickets WHERE customer_id = #{@id};"
    tickets = SqlRunner.run(sql)
    return tickets[0].values
  end

end