class CreateWorkingShiftStaffs < ActiveRecord::Migration[6.1]
  def change
    create_table :working_shift_staffs do |t|
      t.references :working_shift, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
