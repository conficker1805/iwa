after :roles do
  ActiveRecord::Base.connection.execute("TRUNCATE users RESTART IDENTITY CASCADE")

  puts '--- Creating Teachers...'

  teacher = Role.find_by_name('teacher')
  student = Role.find_by_name('student')

  User.create!([
    { name: 'teacher', email: 'teacher@example.com', password: '12345678', role_ids: teacher.id }
  ])

  puts 'Done!'

  puts '--- Creating Student...'

  User.create!([
    { name: 'student', email: 'student@example.com', password: '12345678', role_ids: student.id }
  ])

  puts 'Done!'
end
