# frozen_string_literal: true

class NewUserNotification < Noticed::Base
  deliver_by :database

  params :user

  def title
    "Welcome to Ziggurat!"
  end

  def message
    "Account created #{user.created_at.strftime('%A, %d %b %Y')}"
  end

  def icon
    "https://res.cloudinary.com/lrnzgll/image/upload/v1657463355/user-plus-solid_v2clqz.svg"
  end

  def user
    params[:user]
  end
end
