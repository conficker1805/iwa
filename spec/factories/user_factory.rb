FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { '123123123' }
    password_confirmation { '123123123' }
    name { Faker::Name.name }

    factory :teacher, class: User do
      role_ids { Role.find_by_name('teacher').id }
    end

    factory :student, class: User do
      role_ids { Role.find_by_name('student').id }
    end
  end
end
