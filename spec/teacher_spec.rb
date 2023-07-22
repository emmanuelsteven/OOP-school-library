require_relative '../teacher'

RSpec.describe Teacher do
  context 'When calling method on a teacher' do
    let(:teacher) { Teacher.new('Math', 24, 'jasper', parent_permission: true) }

    it 'should return correct specialization' do
      expect(teacher.specialization).to eq('Math')
    end

    it 'should return correct age' do
      expect(teacher.age).to eq(24)
    end

    it 'should return correct name' do
      expect(teacher.name).to eq('jasper')
    end

    it 'should return correct condition' do
      expect(teacher.can_use_services?).to be(true)
    end

    it 'should convert teacher details to a hash' do
      teacher = Teacher.new('Math', 24, 'Jasper', parent_permission: true)

      expected_hash = {
        'name' => 'Jasper',
        'age' => 24,
        'parent_permission' => true,
        'specialization' => 'Math'
      }

      expect(teacher.to_hash).to eq(expected_hash)
    end
  end
end
