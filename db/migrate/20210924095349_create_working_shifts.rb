class CreateWorkingShifts < ActiveRecord::Migration[6.1]
  def change
    create_table :working_shifts do |t|
      t.datetime :begin_shifts
      t.datetime :end_shifts
      t.string :name

      t.timestamps
    end
  end
end
