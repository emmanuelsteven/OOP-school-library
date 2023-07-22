# class Rental
#   attr_accessor :date, :book, :person

#   def initialize(date, person, book)
#     @date = date

#     @person = person
#     person.rentals << self

#     @book = book
#     book.rentals << self
#   end
# end

class Rental
  attr_accessor :date, :book, :person

  def initialize(date, person, book)
    @date = date

    @person = person
    person.rentals << self

    @book = book
    book.rentals << self
  end

  def to_hash
    {
      'date' => @date,
      'book' => {
        'title' => @book.title,
        'author' => @book.author
      },
      'person' => {
        'name' => @person.name,
        'id' => @person.id,
        'age' => @person.age
      }
    }
  end
end
