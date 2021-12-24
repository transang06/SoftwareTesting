class Room < ApplicationRecord
  has_many :furnitures, dependent: :destroy
  has_many :receipts, dependent: :destroy
  has_many_attached :images

  validates :name, presence: true
  validates :type_room, presence: true

  before_save{name.capitalize!}

  ransack_alias :furnitures,
                :name_or_type_room_or_description_or_furnitures_name
  scope :latest, ->{order created_at: :desc}
  scope :not_in, ->(room_ids){where "rooms.id NOT IN (?)", room_ids}

  class << self
    def ransackable_attributes auth_object = nil
      if auth_object == :admin
        super
      else
        super & %w(name type_room hourly_price
              description furnitures created_at)
      end
    end

    def ransackable_scopes
      %i(latest not_in)
    end
  end
end
