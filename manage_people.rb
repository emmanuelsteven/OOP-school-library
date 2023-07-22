def create_teacher
  puts 'Create a new teacher'
  print 'Enter teacher age: '
  age = gets.chomp
  print 'Enter teacher name: '
  name = gets.chomp
  print 'Enter teacher specialization: '
  specialization = gets.chomp
  teacher = Teacher.new(specialization, age, name, parent_permission: true)
  @people << teacher
  puts 'Teacher created successfully'
end

def create_student
  puts 'Create a new student'
  puts 'Enter student age: '
  age = gets.chomp
  puts 'Enter name: '
  name = gets.chomp
  puts 'Has parent permission? [Y/N]: '
  parent_permission = gets.chomp.downcase
  case parent_permission
  when 'n'
    student = Student.new(nil, age, name, parent_permission: false)
    @people << student
    puts 'Need parent permission to Borrow a book'
  when 'y'
    student = Student.new(nil, age, name, parent_permission: true)
    @people << student
    puts 'Student created successfully'
  end
end
