require_relative '../book'

RSpec.describe Book do
  context 'When you create a book' do
    let(:book) { Book.new('Legend of the seeker', 'Openhiemer') }

    it 'should return correct title' do
      expect(book.title).to eq('Legend of the seeker')
    end

    it 'should return correct author' do
      expect(book.author).to eq('Openhiemer')
    end
  end
end
