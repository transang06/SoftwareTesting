FactoryBot.define do
  factory :room  do
    name {Faker::House.room}
    type_room {Faker::Appliance.brand}
    description {Faker::Restaurant.description}
    hourly_price { 100 }
    day_price { 1300 }
    monthly_price { 8400 }
  end
end
