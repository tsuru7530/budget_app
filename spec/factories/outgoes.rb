FactoryBot.define do
  factory :outgo do
    year {Faker::Number.number(digits: 2)}
    price {Faker::Number.number(digits: 2)}
    memo {Faker::Lorem.characters(number: 20)}
  end
end