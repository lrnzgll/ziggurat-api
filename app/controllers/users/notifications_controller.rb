# frozen_string_literal: true

module Users
  class NotificationsController < ApplicationController
    def index
      @notifications = Current.user.notifications
    end
  end
end
