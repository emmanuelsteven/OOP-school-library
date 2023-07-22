require_relative '../rentals'
require_relative '../student'
require_relative '../book'

describe Rental do
  context 'Testing the Rental class' do
    before(:each) do
      @person = Student.new(nil, 23, 'Sam')
      @book = Book.new('Legend', 'John')
      @rental = Rental.new('2023', @person, @book)
    end

    it 'should add a new rental' do
      name = @rental.person.name
      title = @rental.book.title
      date = @rental.date
      expect(name).to eq('Sam')
      expect(title).to eq('Legend')
      expect(date).to eq('2023')
    end

    it 'should show that "rentals" in Book and Person are updated' do
      expect(@person.rentals.length.positive?).to eq(true)
      expect(@book.rentals.length.positive?).to eq(true)
      expect(@person.rentals[0].person.name).to eq('Sam')
    end

    it 'should convert rental details to a hash' do
      expected_hash = {
        'date' => '2023',
        'book' => {
          'title' => 'Legend',
          'author' => 'John'
        },
        'person' => {
          'name' => 'Sam',
          'id' => @person.id,
          'age' => 23
        }
      }

      expect(@rental.to_hash).to eq(expected_hash)
    end
  end
end
