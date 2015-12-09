module ApplicationHelper
  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-error", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do
               concat message
               concat content_tag(:span, '', class: "close glyphicon glyphicon-remove", data: { dismiss: 'alert' })
             end)
    end
    nil
  end
end