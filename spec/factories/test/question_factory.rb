FactoryBot.define do
  factory :question, class: 'Test::Question' do
    label { Faker::Lorem.sentence }

    options_attributes { [attributes_for(:option, correctness: false), attributes_for(:option)] }
  end
end
