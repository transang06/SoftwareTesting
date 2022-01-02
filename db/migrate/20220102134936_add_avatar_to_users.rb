class AddAvatarToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :photo, :string
  end
end
