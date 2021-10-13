class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :type_room
      t.boolean :status, default: 0
      t.decimal :hourly_price, default: 0
      t.decimal :day_price, default: 0
      t.decimal :monthly_price, default: 0
      t.text :description
      t.decimal :discount, default: 0
      t.integer :amount_of_people, default: 0

      t.timestamps
    end
  end
end
