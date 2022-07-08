# frozen_string_literal: true

class NotificationsController < ApplicationController
  def index
    @notifications = Current.user.notifications
  end
end
