FactoryBot.define do
  factory :receipt do
    user_id {create(:user).id}
    room_id {create(:room).id}
    from_time {time_current}
    end_time {time_current(Settings.hour_1.hour)}
    status {0}
  end
end
