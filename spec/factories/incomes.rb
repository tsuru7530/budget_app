FactoryBot.define do
  factory :income do
    year {Faker::Number.number(digits: 2)}
    category {"現年"}
    price {Faker::Number.number(digits: 8)}
    memo {Faker::Lorem.characters(number: 20)}
  end
end