require_relative '../classroom'
require_relative '../student'

RSpec.describe Classroom do
  context 'When assigning a student to a classroom' do
    it 'successfully adds the student to the classroom' do
      new_classroom = Classroom.new('Math')
      new_student = Student.new(new_classroom, 12, 'Student1', parent_permission: true)
      new_classroom.add_student(new_student)

      expect(new_classroom.students[0].name).to eq('Student1')
      expect(new_student.classrooms.label).to eq('Math')
    end
  end
end
