class Book
  attr_accessor :title, :author, :rentals

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  def to_hash
    {
      'title' => @title,
      'author' => @author
    }
  end

  def add_rental(person, date)
    Rental.new(date, person, self)
  end
end
