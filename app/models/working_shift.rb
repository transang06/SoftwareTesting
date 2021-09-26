class WorkingShift < ApplicationRecord
  has_many :working_shift_staffs, dependent: :destroy
end
