# require './person'
# class Teacher < Person
#   def initialize(specialization, age, name = 'unknown', parent_permission: true)
#     super(age, name, parent_permission: parent_permission)
#     @specialization = specialization
#   end

#   def can_use_services?
#     true
#   end
# end

require './person'
class Teacher < Person
  def initialize(specialization, age, name = 'unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end

  def to_hash
    {
      'name' => @name,
      'age' => @age,
      'parent_permission' => @parent_permission,
      'specialization' => @specialization
    }
  end
end
