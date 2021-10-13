json.array!(@time_busy) do |event|
  json.title distance_of_time_in_words(event.from_time, event.end_time)
  json.start event.from_time
  json.end event.end_time
end
