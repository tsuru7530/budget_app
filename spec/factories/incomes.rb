FactoryBot.define do
  factory :income do
    year {Faker::Number.number(digits: 2)}
    category {"initial"}
    price {Faker::Number.number(digits: 2)}
    memo {Faker::Lorem.characters(number: 20)}
  end
end