# frozen_string_literal: true

module Users
  class PreferencesController < ApplicationController
    def show
      @preferences = Current.user.preferences
    end
  end
end
