require_relative '../base_decorator'
require_relative '../trimmer_decorator'

describe TrimmerDecorator do
  let(:nameable) { double('Nameable') }
  let(:decorator) { TrimmerDecorator.new(nameable) }

  context 'when the name has 10 or fewer characters' do
    it 'should not trim the name' do
      allow(nameable).to receive(:correct_name).and_return('John')

      expect(decorator.correct_name).to eq('John')
    end
  end
end
