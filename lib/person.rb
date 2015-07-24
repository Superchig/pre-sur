# Represents a person at a very basic level.
# Perhaps it ought to be renamed to President?
class Person
  STILL_ALIVE = 4096

  attr_reader :name, :birth_year, :death_year

  def initialize(name, birth_year, death_year = STILL_ALIVE)
    @name = name
    @birth_year = birth_year
    @death_year = death_year
  end

  def alive_in(year)
    year.between?(birth_year, death_year)
  end

  def to_s
    (@death_year == STILL_ALIVE) ?
      "#{@name}, born in #{@birth_year} and currently alive." :
      "#{@name}, born in #{@birth_year}, died in #{@death_year}."
  end
end

# Gives array ways to easily select and count people alive in a given year.
class Array
  # Only works on arrays of Persons
  def select_people_alive_in(year)
    select { |person| person.alive_in(year) }
  end

  def amount_of_people_alive_in(year)
    amount = 0

    each { |person| amount += 1 if person.alive_in(year) }

    amount
  end

  def concise_alive_in(year)
    select_people_alive_in(year).map(&:name).join(', ')
  end

  def most_people_alive_between(first_year, last_year)
    presidents_alive = {}

    (first_year..last_year).each do |year|
      num_of_people = 0

      each do |person|
        num_of_people += 1 if person.alive_in(year)
      end

      presidents_alive[year] = num_of_people
    end

    presidents_alive
  end
end

# Defines methods for use with Person
class Hash
  def newline_print
    counter = 0

    each do |key, value|
      counter += 1
      print "#{key} => #{value}; "

      if counter >= 4
        counter = 0
        puts ""
      end
    end
  end

  def max
    maximum = values.max
  end
end
