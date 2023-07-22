require_relative '../student'

RSpec.describe Student do
  context 'When initializing a student' do
    it 'should set the student\'s age correctly' do
      new_student = Student.new([], 24, 'jasper', parent_permission: true)
      expect(new_student.age).to eq(24)
    end

    it 'should set the student\'s name correctly' do
      new_student = Student.new([], 24, 'jasper', parent_permission: true)
      expect(new_student.name).to eq('jasper')
    end

    it 'should set the student\'s parent\'s parent_permission correctly' do
      new_student = Student.new([], 24, 'jasper', parent_permission: true)
      expect(new_student.parent_permission).to be(true)
    end
  end

  context 'When calling methods on a student' do
    let(:student) { Student.new([], 24, 'jasper', parent_permission: true) }

    it 'should return hooky symbol' do
      expect(student.play_hooky).to eq( '¯\(ツ)/¯')
    end
  end
end
