class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :phone
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.string :address
      t.boolean :gender
      t.text :description
      t.string :identifier
      t.integer :role, default: 0
      t.string :remember_digest
      t.string :activation_digest
      t.datetime :activated_at
      t.string :reset_digest
      t.datetime :reset_sent_at

      t.timestamps
    end
  end
end
