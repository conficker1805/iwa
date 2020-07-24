FactoryBot.define do
  factory :option, class: 'Test::Option' do
    label { Faker::Lorem.sentence }
    correctness { true }
  end
end
