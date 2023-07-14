require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rentals'
require_relative 'classroom'

class App
    def initialize
      @people = []
      @books = []
      @rentals = []
    end
  
    def list_all_books
      puts 'All Books:'
      @books.each do |book|
        puts "Title: #{book.title}, Author: #{book.author} \n \n"
      end
    end
  
    # def list_all_people
    #   puts 'All People:'
    #   @people.each do |person|
    #     puts "ID: #{person.id}, Name: #{person.name}, Age: #{person.age} \n \n"
    #   end
    # end
    def list_all_persons
        puts 'No person available in the DataBase.' if @persons.empty?
        @persons.each do |person|
          puts "[#{person.class.name}] Name: #{person.name}, Age: #{person.age}, id: #{person.id}"
        end
      end
    
      def create_person
        print 'To create a student, press 1, to create a teacher, press 2 : '
        option = gets.chomp
    
        case option
        when '1'
          create_student
        when '2'
          create_teacher
        else
          puts 'Invalid input. Try again.'
        end
      end
    
      def create_student
        puts 'Create a new student'
        puts 'Enter student age: '
        age = gets.chomp.to_i
        puts 'Enter name: '
        name = gets.chomp
        puts 'Has parent permission? [Y/N]: '
        parent_permission = gets.chomp.downcase
        case parent_permission
        when 'n'
          student = Student.new(age, name, parent_permission: false)
          @persons << student
          puts 'Need parent permission to Borrow a book'
        when 'y'
          student = Student.new(age, name, parent_permission: true)
          @persons << student
          puts 'Student created successfully'
        end
      end
    
      def create_teacher
        puts 'Create a new teacher'
        print 'Enter teacher age: '
        age = gets.chomp.to_i
        print 'Enter teacher name: '
        name = gets.chomp
        print 'Enter teacher specialization: '
        specialization = gets.chomp
        teacher = Teacher.new(specialization, age, name)
        @persons << teacher
        puts 'Teacher created successfully'
      end
    
    # def create_person
    #   puts 'Enter person type (student/teacher):'
    #   person_type = gets.chomp.downcase
  
    #   puts 'Enter name:'
    #   name = gets.chomp
  
    #   puts 'Enter age:'
    #   age = gets.chomp.to_i
  
    #   case person_type
    #   when 'student'
    #     create_student(name, age, paren)
    #   when 'teacher'
    #     create_teacher(name, age)
    #   else
    #     puts 'Invalid person type!'
    #     return
    #   end
  
    #   puts "Person created successfully.\n \n"
    # end
  
    # def create_student(name, age)
    # #   puts 'Enter classroom:'
    # #   classroom = gets.chomp
    #   person = Student.new(name, age)
    #   @people << person

    # end
  
    # def create_teacher(name, age)
    #   puts 'Enter specialization:'
    #   specialization = gets.chomp
    #   person = Teacher.new(name, age, specialization)
    #   @people << person
    # end
  
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
      puts 'Enter person ID:'
      person_id = gets.chomp.to_i
  
      person = @people.find { |p| p.id == person_id }
      unless person
        puts "Person with ID #{person_id} not found!\n \n"
        return
      end
  
      puts 'Enter book title:'
      book_title = gets.chomp
  
      book = @books.find { |b| b.title == book_title }
      unless book
        puts "Book with title '#{book_title}' not found!\n \n"
        return
      end
  
      puts 'Enter rental date:'
      date = gets.chomp
  
      rental = Rental.new(person, book, date)
      @rentals << rental
  
      puts "Rental created successfully.\n \n"
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
      case option
      when 1
        list_all_books
      when 2
        list_all_people
      when 3
        create_person
      when 4
        create_book
      when 5
        create_rental
      when 6
        list_rentals_for_person
      else
        puts "Invalid option!\n \n"
      end
    end
  
    def list_rentals_for_person
      puts 'Enter person ID:'
      person_id = gets.chomp.to_i
      person = @people.find { |p| p.id == person_id }
      unless person
        puts "Person with ID #{person_id} not found!\n \n"
        return
      end
      puts "Rentals for Person ID #{person_id}:"
      rentals = @rentals.select { |rental| rental.person == person }
      rentals.each do |rental|
        puts "Book: #{rental.book.title}, Date: #{rental.date}\n \n"
      end
    end
  end