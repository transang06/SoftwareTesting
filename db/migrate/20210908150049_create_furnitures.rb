class CreateFurnitures < ActiveRecord::Migration[6.1]
  def change
    create_table :furnitures do |t|
      t.references :room, null: false, foreign_key: true
      t.string :name
      t.integer :quantity, default: 0
      t.text :description

      t.timestamps
    end
  end
end
