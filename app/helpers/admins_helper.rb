module AdminsHelper
  def color_text status
    case status
    when "wait"
      "text-info"
    when "approved"
      "text-success"
    when "complete"
      "text-primary"
    when "cancelled_by_you"
      "text-danger"
    when "cancelled_by_admin"
      "text-muted"
    end
  end
end
