require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rentals'
require_relative 'classroom'

class App
  def initialize
    @persons = []
    @books = []
    @rentals = []
  end

  def list_all_books
    puts 'All Books:'
    @books.each do |book|
      puts "Title: #{book.title}, Author: #{book.author} \n \n"
    end
  end

  def list_all_people
    puts 'No person available in the DataBase.' if @persons.empty?
    @persons.each do |person|
      puts "[#{person.class.name}] Name: #{person.name}, Age: #{person.age}, id: #{person.id}"
    end
  end

  def create_person
    print 'To create a student, press 1, to create a teacher, press 2 : '
    option = gets.chomp.to_i

    case option
    when 1
      create_student
    when 2
      create_teacher
    else
      puts 'Invalid input. Try again.'
    end
  end

  def create_student
    puts 'Create a new student'
    puts 'Enter student age: '
    age = gets.chomp
    puts 'Enter name: '
    name = gets.chomp
    puts 'Has parent permission? [Y/N]: '
    parent_permission = gets.chomp.downcase
    case parent_permission
    when 'n'
      student = Student.new(nil, age, name, parent_permission: false)
      @persons << student
      puts 'Need parent permission to Borrow a book'
    when 'y'
      student = Student.new(nil, age, name, parent_permission: true)
      @persons << student
      puts 'Student created successfully'
    end
  end

  def create_teacher
    puts 'Create a new teacher'
    print 'Enter teacher age: '
    age = gets.chomp
    print 'Enter teacher name: '
    name = gets.chomp
    print 'Enter teacher specialization: '
    specialization = gets.chomp
    teacher = Teacher.new(specialization, age, name, parent_permission: true)
    @persons << teacher
    puts 'Teacher created successfully'
  end

  def create_book
    puts 'Enter title:'
    title = gets.chomp

    puts 'Enter author:'
    author = gets.chomp

    book = Book.new(title, author)
    @books << book

    puts "Book created successfully. \n \n"
  end

  def create_rental
    return if @books.empty? || @persons.empty?

    puts 'Select a book from the following list of number'
    @books.each_with_index { |book, index| puts "#{index}) Title: #{book.title}, Author: #{book.author}" }
    book = gets.chomp.to_i

    puts 'Select a person from the following list of number (not ID)'
    @persons.each_with_index do |person, index|
      puts "#{index}) Name: #{person.name} Age: #{person.age} Id: #{person.id}"
    end
    person = gets.chomp.to_i

    print 'Date: '
    date = gets.chomp

    rental = Rental.new(date, @persons[person], @books[book])
    @rentals << rental

    puts 'Rental created successfully'
  end

  def run
    loop do
      display_menu
      option = gets.chomp.to_i
      process_option(option)
      break if option == 7
    end
  end

  def display_menu
    puts "Welcome to School Library App\n \n"
    puts 'Choose an option by entering a number:'
    puts '1. List all books'
    puts '2. List all people'
    puts '3. Create a person'
    puts '4. Create a book'
    puts '5. Create a rental'
    puts '6. List rentals for a person'
    puts '7. Quit'
  end

  def process_option(option)
    options = {
      1 => method(:list_all_books),
      2 => method(:list_all_people),
      3 => method(:create_person),
      4 => method(:create_book),
      5 => method(:create_rental),
      6 => method(:list_rentals_for_person),
      7 => method(:say_goodbye)
    }

    action = options[option]
    if action
      action.call
    else
      handle_invalid_option
    end
  end

  def say_goodbye
    puts "Goodbye!\n \n"
  end

  def handle_invalid_option
    puts "Invalid option!\n \n"
  end

  def list_rentals_for_person
    print 'Person ID: '
    id = gets.chomp.to_i
    @rentals.each do |rent|
      puts "Date: #{rent.date}, Book: \"#{rent.book.title}\" by #{rent.book.author}" if rent.person.id == id
    end
  end
end
