# Represents a person at a very basic level.
# Perhaps it ought to be renamed to President?
class Person
  # Internal: Value for death_year that signifies that the Person has not yet died.
  STILL_ALIVE = 4096

  attr_reader :name, :birth_year, :death_year

  # Internal: Initialize a new Person.
  #
  # name - The String that holds the value of the Person's name.
  # birth_year - The Integer that is the year in which the Person was born.
  # death_year - The Integer that is the year in which the Person died.
  #              If it's value is equivalent to STILL_ALIVE,
  #              then to_s will say that the person is currently alive.
  #              (default: STILL_ALIVE)
  #
  # Examples
  #
  # lincoln = Person.new("Abraham Lincoln", 1809, 1865)
  # obama = Person.new("Barack Obama", 1961) # Is still alive
  def initialize(name, birth_year, death_year = STILL_ALIVE)
    @name = name
    @birth_year = birth_year
    @death_year = death_year
  end

  # Public: Tell whether or not this person was alive in a given year.
  #
  # year - The Integer that is to be checked of whether or not the Person was
  #        alive in.
  #
  # Examples
  #
  # lincoln.alive_in?(1999) # false
  #
  # Returns whether or not Person was alive in a year.
  def alive_in?(year)
    year.between?(@birth_year, @death_year)
  end

  # Public: Converts Person to a string.
  #
  # Examples
  #
  # lincoln.to_s
  # => "Abraham Lincoln, born in 1809, died in 1865."
  #
  # Returns this String.
  def to_s
    (@death_year == STILL_ALIVE) ?
      "#{@name}, born in #{@birth_year} and currently alive." :
      "#{@name}, born in #{@birth_year}, died in #{@death_year}."
  end
end

# Gives array ways to easily select and count people alive in a given year.
class Array
  # Public: Creates array of Persons alive in a given year.
  #
  # year - The Integer form of the year that all of the new array's Persons were
  #        alive in.
  #
  # Examples
  #
  # soldiers.select_people_alive_in(1777)
  # swordsmen.select_people_alive_in(1332)
  #
  # Returns the array.
  def select_people_alive_in(year)
    select { |person| person.alive_in?(year) }
  end

  # Public: Counts the amount of people alive in a given year.
  #
  # year - The Integer representation of the year to check when the people in
  #        the array were alive with.
  #
  # Examples
  #
  # soldiers.amount_of_people_alive_in(1777)
  # => 79_103
  # archers.select_people_alive_in(1341)
  # => 342
  #
  # Returns the counted amount.
  def amount_of_people_alive_in(year)
    amount = 0

    each { |person| amount += 1 if person.alive_in?(year) }

    amount
  end

  # Public: Creates a string of the names of all the Persons alive in a year,
  #         separated by commas.
  #
  # year - The Integer representation of the year to check when the people in
  #        the array were alive with.
  #
  # Examples
  #
  # enemies.concise_alive_in(2020)
  # => "Weirdo McBadname, Yorith Htiroy, Sneer Laughs"
  #
  # Returns the string of names.
  def concise_alive_in(year)
    select_people_alive_in(year).map(&:name).join(', ')
  end

  def most_people_alive_between(first_year, last_year)
    presidents_alive = {}

    (first_year..last_year).each do |year|
      num_of_people = 0

      each do |person|
        num_of_people += 1 if person.alive_in?(year)
      end

      presidents_alive[year] = num_of_people
    end

    presidents_alive
  end
end

# Defines methods for use with Person
class Hash
  # Prints its own contents, with a newline every 4 key-value pairs.
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

  # Returns the maximum value(s), in the form of a hash.
  def max
    maximum = values.max
    select { |k, v| v == maximum }
  end
end
