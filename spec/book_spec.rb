require_relative '../book'
require_relative '../rentals'

RSpec.describe Book do
  context 'When you create a book' do
    let(:book) { Book.new('Legend of the seeker', 'Openhiemer') }

    it 'should return correct title' do
      expect(book.title).to eq('Legend of the seeker')
    end

    it 'should return correct author' do
      expect(book.author).to eq('Openhiemer')
    end

    it 'should convert book details to a hash' do
      expected_hash = {
        'title' => 'Legend of the seeker',
        'author' => 'Openhiemer'
      }

      expect(book.to_hash).to eq(expected_hash)
    end
  end
end
