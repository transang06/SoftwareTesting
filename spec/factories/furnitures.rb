FactoryBot.define do
  factory :furniture  do
    room_id {create(:room).id}
    name {Faker::House.furniture}
    quantity {2}
    description {Faker::Restaurant.description}
  end
end
