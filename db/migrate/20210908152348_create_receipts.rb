class CreateReceipts < ActiveRecord::Migration[6.1]
  def change
    create_table :receipts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.string :payment
      t.datetime :check_in
      t.datetime :check_out
      t.datetime :from_time
      t.datetime :end_time
      t.decimal :hourly_price, default: 0
      t.decimal :day_price, default: 0
      t.decimal :monthly_price, default: 0
      t.decimal :into_money
      t.decimal :paid
      t.datetime :paid_at
      t.integer :status, default: 0
      
      t.timestamps
    end
  end
end
