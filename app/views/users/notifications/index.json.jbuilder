# frozen_string_literal: true

json.notifications do
  json.array! @notifications do |notification|
    json.title notification.title
    json.message notification.message
    json.icon notification.icon
  end
end
