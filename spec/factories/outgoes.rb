FactoryBot.define do
  factory :outgo do
    year {Faker::Number.number(digits: 2)}
    price {Faker::Number.number(digits: 2)}
    memo {Faker::String.random(length: 20)}
  end
end