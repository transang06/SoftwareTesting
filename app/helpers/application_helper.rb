module ApplicationHelper
  def full_title page_title = ""
    base_title = t "title_page"
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end

  def parse_time time
    DateTime.parse(time).strftime(Settings.format_time)
  end

  def time_current hour = 0
    (Time.current + Settings.hour_1.hour + hour).strftime Settings.format_time
  end

  def room room_id
    @room = Room.find_by(id: room_id)
  end

  def active_class controller, action
    current_page?(controller: controller, action: action) ? "active" : ""
  end
end
