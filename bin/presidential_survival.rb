require 'require_all'
require 'rainbow'

require_rel '../lib'

# Mass initialization of presidents.
$PRESIDENTS = [
  Person.new("George Washington", 1732, 1799),
  Person.new("John Adams", 1735, 1826),
  Person.new("Thomas Jefferson", 1743, 1826),
  Person.new("James Madison", 1751 ,1836),
  Person.new("James Monroe", 1758, 1831),
  Person.new("John Quincy Adams", 1767, 1848),
  Person.new("Andrew Jackson", 1767 ,1845),
  Person.new("Martin Van Buren", 1782, 1862),
  Person.new("William Henry Harrison", 1773, 1841),
  Person.new("John Tyler", 1790, 1862),
  Person.new("James K. Polk", 1795, 1849),
  Person.new("Zachary Taylor", 1784, 1850),
  Person.new("Millard Fillmore", 1800, 1874),
  Person.new("Franklin Pierce", 1804, 1869),
  Person.new("James Buchanan", 1791, 1868),
  Person.new("Abraham Lincoln", 1809, 1865),
  Person.new("Andrew Johnson", 1808, 1875),
  Person.new("Ulysses S. Grant", 1822, 1885),
  Person.new("Rutherford B. Hays", 1822, 1893),
  Person.new("James A. Garfield", 1831, 1881),
  Person.new("Chester A. Arthur", 1829, 1886),
  Person.new("Grover Cleveland", 1837, 1908),
  Person.new("Benamin Harrison", 1833, 1901),
  Person.new("William McKinley", 1843, 1901),
  Person.new("Theodore Roosevelt", 1858, 1919),
  Person.new("William Howard Taft", 1857, 1930),
  Person.new("Woodrow Wilson", 1856, 1924),
  Person.new("Warren G. Harding", 1865, 1923),
  Person.new("Calvin Coolidge", 1872, 1933),
  Person.new("Herbert Hoover", 1874, 1964),
  Person.new("Franklin D. Roosevelt", 1882, 1945),
  Person.new("Harry S. Truman", 1884, 1972),
  Person.new("Dwight D. Eisenhower", 1890, 1969),
  Person.new("John F. Kennedy", 1917, 1963),
  Person.new("Lyndon B. Johnson", 1908, 1973),
  Person.new("Richard Nixon", 1913, 1994),
  Person.new("Gerald Ford", 1913, 2006),
  Person.new("Jimmy Carter", 1924),
  Person.new("Ronald Reagan", 1911, 2004),
  Person.new("George H. W. Bush", 1924),
  Person.new("Bill Clinton", 1946),
  Person.new("George W. Bush", 1946),
  Person.new("Barack Obama", 1961),
]

$EARLIEST_BIRTH = 1732
$CURRENT_YEAR = 2015

def eval_choice(choice)
  case choice
  when '1'
    if (year = get_year)
      print_num_alive(year)
    end
  when '2'
    if (year = get_year)
      print_names_alive(year)
    end
  when '3'
    if (year = get_year)
      print_presidents_alive(year)
    end
  when '4'
    $PRESIDENTS.most_people_alive_between($EARLIEST_BIRTH, $CURRENT_YEAR).newline_print
  when 'q'
    return true
  else
    puts "That's not a valid choice!"
  end

  false
end

def get_year
  print "Year> "

  year = $stdin.gets.chomp.to_i

  if year < $EARLIEST_BIRTH
    puts Rainbow("That year is before the earliest birthyear!").fg(:green).bright.underline
  elsif year > $CURRENT_YEAR
    puts Rainbow("That year is in the future!").fg(:green).bright.underline
  else
    year
  end
end

def color_year(year)
  Rainbow(year).fg(:red).underline
end

def color_generic(message)
  Rainbow(message).fg(:blue).bright
end

def color_ans(answer)
  Rainbow(answer).fg(:yellow)
end

def print_num_alive(year)
  people_alive = $PRESIDENTS.amount_of_people_alive_in(year)

  color_year = color_year(year)
  ad = color_generic("A.D.:")
  generic_message = color_generic("Number of presidents alive in")
  puts generic_message + " " + color_year + " " + ad + " " + color_ans("#{people_alive}.")
end

def print_names_alive(year)
  names = $PRESIDENTS.concise_alive_in(year)

  color_year = color_year(year)
  ad = color_generic("A.D.:")
  generic_message = color_generic("Presidents alive in")
  puts generic_message + " " + color_year + " " + ad + " " + color_ans(names + ".")
end

def print_presidents_alive(year)
  alive = $PRESIDENTS.select_people_alive_in(year)

  color_year = color_year(year)
  ad = color_generic("A.D.:")
  generic_message = color_generic("Presidents alive in")
  puts "#{generic_message} #{color_year} #{ad}"

  alive.each { |person| puts color_ans(person) }
end

loop do
  puts <<-EOT
Welcome to Presidential Survival!
Where you can learn how many U.S. (former) presidents were alive at any given year!
EOT

  puts <<-EOT
Would you like to know about:
1. The number of U.S. presidents that were alive in a year.
2. The names of the U.S. presidents alive in a year.
3. The names, years of birth, and years of death of the presidents alive in a year.
4. See a list of years of the U.S. presidency.
q. Quit.
EOT

  print "> "

 choice = $stdin.gets.chomp

 break if eval_choice(choice)
end
