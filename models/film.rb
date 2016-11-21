require('pg')
require('pry-byebug')
require_relative("../db/sql_runner")
require_relative('ticket')

class Film

  attr_reader :id
  attr_accessor :title, :price 

  def initialize( options )
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price']
  end

  def save()
    sql = "INSERT INTO films (title , price) VALUES ('#{ @title }', #{@price}) RETURNING id"
    film = SqlRunner.run( sql ).first
    @id = film['id'].to_i
  end

  def delete
    return unless @id
    sql = "DELETE FROM films WHERE id = '#{@id}'"
    result = SqlRunner.run( sql )
  end

  def update
    sql = "UPDATE films SET (title) = ('#{@title}') WHERE id = (#{@id})"
    result = SqlRunner.run( sql )
  end

  def self.all()
    sql = "SELECT * FROM films"
    film = SqlRunner.run(sql)
    result = film.map { film| Customer.new(film ) }
    return result
  end

  def self.delete_all() 
    sql = "DELETE FROM films"
    film = SqlRunner.run(sql)
    result = film.map { film| Customer.new(film ) }
    return result
  end

  def number_of_customers()
    sql = "SELECT count(film_id) FROM tickets WHERE film_id = #{@id};"
    audit = SqlRunner.run(sql)
    return audit[0].values
  end

end