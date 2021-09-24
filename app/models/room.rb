class Room < ApplicationRecord
  has_many :furnitures, dependent: :destroy
  has_many :receipts, dependent: :destroy
  has_many_attached :images

  scope :latest, ->{order name: :desc}
  scope :search_name_furnitures, (lambda do |key|
    joins(:furnitures)
      .where("furnitures.name LIKE ?", "%#{key}%")
  end)
  scope :search_name_rooms, (lambda do |key|
    where("rooms.name LIKE ? OR rooms.type_room LIKE ?", "%#{key}%", "%#{key}%")
  end)
  scope :search_price, (lambda do |min, max|
    where("(rooms.hourly_price >= ? AND rooms.hourly_price <= ?)
          OR (rooms.day_price >= ? AND rooms.day_price <= ?)
          OR (rooms.monthly_price >= ? AND rooms.monthly_price <= ?)",
          min, max, min, max, min, max)
  end)
  scope :search_time, ->(room_ids){where "rooms.id NOT IN (?)", room_ids}
  scope :room_on_busy, (lambda do |from, to|
    joins(:receipts)
    .where("receipts.from_time >= ? AND receipts.end_time <= ?", from, to)
    .select("rooms.id").distinct
  end)
end
