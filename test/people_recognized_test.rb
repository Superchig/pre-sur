require 'minitest'
require 'minitest/autorun'
require 'require_all'
require 'set'

require_rel '../lib'

class PeopleRecognizedTest < Minitest::Test
  def setup
    @chiggie = Person.new("Christopher Kailong Chang", 2001)
    @adam = Person.new("Adam Hope", 2001)
    @elvis = Person.new("Elvis Aaron Presley", 1935, 1977)
    @danielle = Person.new("Danielle Riley Keough", 1989) # Elvis' grandaughter
    @diane = Person.new("Diane Hsiung Chang", 1963)
    @forrest = Person.new("Forrest Chang", 1967)
    @jack = Person.new("Jack Bloom", 2001)

    @people = [
      @chiggie, @adam, @jack, @elvis, @danielle, @diane, @forrest
    ]
  end

  def test_select_people_alive_in
    people_who_should_be_alive = [
      @diane, @forrest, @danielle
    ]

    assert_equal(people_who_should_be_alive.to_set, @people.select_people_alive_in(1999).to_set)
  end

  def test_amount_of_people_alive_in
    amount = 1

    assert_equal(amount, @people.amount_of_people_alive_in(1954))
  end
end
