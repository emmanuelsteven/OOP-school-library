require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rentals'
require_relative 'manage_people'
require 'json'
require_relative 'create_book'

class App
  attr_accessor :books, :people, :rentals

  def initialize
    @books = load_books_data
    @people = load_people_data
    @rentals = load_rentals_data
  end

  def save_books_data
    save_data(@books, './data/books.json')
  end

  def save_people_data
    save_data(@people, './data/people.json')
  end

  def save_rentals_data
    save_data(@rentals, './data/rentals.json')
  end

  def save_data(data, file_path)
    return if data.empty?

    # file_data = data.map(&:to_hash)
    # File.write(file_path, JSON.generate(file_data))
    File.write(file_path, JSON.generate(data.map(&:to_hash)))
  end

  def list_books
    @books.each { |book| puts "Title: #{book.title},  Author: #{book.author}" }
  end

  def list_people
    @people.each { |person| puts "[#{person.class}] Name: #{person.name}, Age: #{person.age}, id: #{person.id}" }
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

  def create_rental
    return if @books.empty? || @people.empty?

    puts 'Select a book from the following list of number'
    @books.each_with_index { |book, index| puts "#{index}) Title: #{book.title}, Author: #{book.author}" }
    book = gets.chomp.to_i

    puts 'Select a person from the following list of number (not ID)'
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name} Age: #{person.age} Id: #{person.id}"
    end
    person = gets.chomp.to_i

    print 'Date [YY-MM-DD]:'
    date = gets.chomp

    rental = Rental.new(date, @people[person], @books[book])
    @rentals << rental

    puts 'Rental created successfully'
  end

  def load_books_data
    file_data = File.read('./data/books.json')
    @books = if file_data
               JSON.parse(file_data).map do |book_data|
                 Book.new(book_data['title'], book_data['author'])
               end
             else
               []
             end
  rescue Errno::ENOENT, JSON::ParserError
    @books = []
  end

  def load_people_data
    file_data = File.read('./data/people.json')
    @people = JSON.parse(file_data).map do |person_data|
      if person_data['classification'] == 'Student'
        Student.new(nil, person_data['age'], person_data['name'])
      elsif person_data['classification'] == 'Teacher'
        Teacher.new(person_data['age'], person_data['name'], person_data['specialization'])
      else
        Person.new(person_data['age'], person_data['name'])
      end
    end
  rescue Errno::ENOENT, JSON::ParserError
    @people = []
  end

  # def load_rentals_data
  #   file_data = File.read('./data/rentals.json')
  #   @rentals = if file_data
  #                JSON.parse(file_data).map do |rental_data|
  #                  book_data = rental_data['book']
  #                  person_data = rental_data['person']

  #                  book = @books.select do |item|
  #                    item.title == book_data['title'] && item.author == book_data['author']
  #                  end.first
  #                  person = @people.select do |item|
  #                    item.name == person_data['name'] && item.age == person_data['age']
  #                  end.first

  #                  Rental.new(rental_data['date'], person, book) if !person.nil? && !book.nil?
  #                end
  #              else
  #                []
  #              end
  # rescue Errno::ENOENT, JSON::ParserError
  #   @rentals = []
  # end
  def load_rentals_data
    file_data = File.read('./data/rentals.json')
    @rentals = parse_rentals_data(file_data)
  rescue Errno::ENOENT, JSON::ParserError
    @rentals = []
  end

  def parse_rentals_data(file_data)
    return [] if file_data.nil?

    JSON.parse(file_data).map do |rental_data|
      book_data = rental_data['book']
      person_data = rental_data['person']

      book = find_book(book_data)
      person = find_person(person_data)

      Rental.new(rental_data['date'], person, book) if person && book
    end.compact
  end

  def find_book(book_data)
    @books.find do |item|
      item.title == book_data['title'] && item.author == book_data['author']
    end
  end

  def find_person(person_data)
    @people.find do |item|
      item.name == person_data['name'] && item.age == person_data['age']
    end
  end

  def options
    puts "Welcome to School Library App\n \n"
    puts 'Choose an option by entering a number:'
    puts '1. List all books'
    puts '2. List all people'
    puts '3. Create a person (student or teacher)'
    puts '4. Create a book'
    puts '5. Create a rental'
    puts '6. List rentals for a person'
    puts '7. Quit'
  end

  def process_option(option)
    options = {
      1 => method(:list_books),
      2 => method(:list_people),
      3 => method(:create_person),
      4 => method(:create_book),
      5 => method(:create_rental),
      6 => method(:list_rental),
      7 => method(:say_goodbye)
    }

    action = options[option]
    if action
      action.call
    else
      invalid_option
    end
  end

  def say_goodbye
    save_books_data
    save_people_data
    save_rentals_data
    puts "Goodbye!\n \n"
    exit
  end

  def invalid_option
    puts "Invalid option!\n \n"
  end

  def list_rental
    puts 'Enter the ID of the person to list their rentals'
    id = gets.chomp.to_i
    selected_person = @people.find { |persons| persons.id == id }
    if selected_person
      puts "Rentals for #{selected_person.name}:"
      @rentals.each do |rental|
        puts "Date: #{rental.date}, Book: #{rental.book.title}" if rental.person.id == selected_person.id
      end
      # person.rentals.each { |rental| puts "Date: #{rental.date}, Book: #{rental.book.title}" }
    else
      puts 'Person not found'
    end
  end
end
