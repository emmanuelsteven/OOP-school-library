def create_book
  puts 'Enter title:'
  title = gets.chomp

  puts 'Enter author:'
  author = gets.chomp

  book = Book.new(title, author)
  @books << book

  puts "Book created successfully. \n \n"
end
