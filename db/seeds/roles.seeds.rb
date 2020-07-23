ActiveRecord::Base.connection.execute("TRUNCATE roles RESTART IDENTITY CASCADE")
ActiveRecord::Base.connection.execute("TRUNCATE users_roles RESTART IDENTITY CASCADE")

puts '--- Creating Roles...'

Role.create([
  { name: :teacher },
  { name: :student }
])

puts 'Done!'

