FactoryBot.define do
  factory :test do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence }
    user

    questions_attributes { [FactoryBot.attributes_for(:question)] }
  end
end

