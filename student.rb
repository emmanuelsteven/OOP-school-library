require './person'

class Student < Person
  attr_accessor :classrooms

  def initialize(classrooms, age, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @classrooms = classrooms
  end

  def play_hooky
    '¯\(ツ)/¯'
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end

  def to_hash
    {
      'name' => @name,
      'age' => @age,
      'parent_permission' => @parent_permission,
      'classrooms' => @classrooms
    }
  end
end
