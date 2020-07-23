after :roles do
  ActiveRecord::Base.connection.execute("TRUNCATE users RESTART IDENTITY CASCADE")

  puts '--- Creating Teachers...'

  teachers = User.create!([
    { email: 'teacher@example.com',  password: '12345678' }
  ])

  teachers.each { |u| u.add_role :teacher }

  puts 'Done!'

  puts '--- Creating Student...'

  students = User.create!([
    email: 'student@example.com', password: '12345678'
  ])

  students.each { |u| u.add_role :student }

  puts 'Done!'
end
