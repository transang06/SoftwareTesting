User.create!(first_name: "Trần",
  last_name: "Văn Sáng",
  email: "vansang10a6txqt@gmail.com",
  password: "vansang12",
  password_confirmation: "vansang12",
  phone: "0349934988",
  role: 1,
  activated_at: Time.zone.now)

User.create!(first_name: "Trần",
  last_name: "Văn Sáng",
  email: "vansang@gmail.com",
  password: "vansang12",
  password_confirmation: "vansang12",
  phone: "0349934988",
  activated_at: Time.zone.now)

30.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(first_name: name, 
    last_name: "sang",
    email: email,
    password: password,
    password_confirmation: password,
    phone: "0349934988",
    activated_at: Time.zone.now)
end

30.times do |n|
  name = "Penthouse#{n+1}"
  price = n*10000
  room = Room.create!(name: name,
    type_room: "Luxury room",
    status: 0,
    hourly_price: price,
    day_price: price*8,
    monthly_price: price*89,
    description: "Relax at the penthouse on the 100th floor")
    room.images.attach(io: File.open(Rails.root.join("app/assets/images/room.jpg")),filename: "room.jpg")
    room.images.attach(io: File.open(Rails.root.join("app/assets/images/room2.jpg")),filename: "room2.jpg")
end

rooms = Room.order(:created_at).take(10)
rooms.each { |room| room.furnitures.create!(name: "Dieu hoa", quantity: 2) }
