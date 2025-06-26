FactoryBot.define do
  factory :income do
    year {Faker::Number.number(digits: 2)}
    category {Faker::String.random(length: 20)}
    price {Faker::Number.number(digits: 2)}
    memo {Faker::String.random(length: 20)}
  end
end