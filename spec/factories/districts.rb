FactoryBot.define do
  factory :district do
    name {Faker::Address.street_name}
    year {Faker::Number.number(digits: 2)}
    office {Faker::Company.department}
    latitude {Faker::Number.between(from: -180, to: 180)}
    longitude {Faker::Number.between(from: -180, to: 180)}
    image_delete {"0"}
    after(:build) do |district|
      district.image.attach(io: File.open('spec/fixtures/test_image.png'), filename: 'test_image.png', content_type: 'image/png')
    end
  end
end