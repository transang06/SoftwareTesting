class Room < ApplicationRecord
  has_many :furnitures, dependent: :destroy
  has_many :receipts, dependent: :destroy
  has_many_attached :images

  validates :name, presence: true
  validates :type_room, presence: true

  before_save{name.capitalize!}

  scope :latest, ->{order name: :desc}
  scope :price_greater, (lambda do |price|
    where("hourly_price >= ?", price) if price.present?
  end)
  scope :price_less, (lambda do |price|
    where("hourly_price <= ?", price) if price.present?
  end)
  scope :name_has, (lambda do |key|
    if key.present?
      joins(:furnitures)
      .where("furnitures.name LIKE ? OR rooms.name LIKE ? OR type_room LIKE ?",
             "%#{key}%", "%#{key}%", "%#{key}%")
    end
  end)
  scope :not_in, ->(room_ids){where "rooms.id NOT IN (?)", room_ids}
end
