User.create!(first_name: "Trần",
  last_name: "Văn Sáng",
  email: "vansang10a6txqt@gmail.com",
  password: "vansang12",
  password_confirmation: "vansang12",
  phone: "0349934988",
  role: 1,
  confirmed_at: Time.zone.now)

User.create!(first_name: "Trần",
  last_name: "Văn Sáng",
  email: "vansang@gmail.com",
  password: "vansang12",
  password_confirmation: "vansang12",
  phone: "0349934988",
  confirmed_at: Time.zone.now)

30.times do |n|
  name = Faker::House.room
  price = n*10000
  room = Room.create!(name: name,
    type_room: Faker::Appliance.brand,
    status: 0,
    hourly_price: price,
    day_price: price*8,
    monthly_price: price*89,
    description: Faker::Restaurant.description)
    room.images.attach(io: File.open(Rails.root.join("app/assets/images/room.jpg")),filename: "room.jpg")
    room.images.attach(io: File.open(Rails.root.join("app/assets/images/room2.jpg")),filename: "room2.jpg")
end

rooms = Room.order(:created_at).take(10)
rooms.each { |room| room.furnitures.create!(name: Faker::House.furniture, quantity: 2, description: Faker::Restaurant.description)}
