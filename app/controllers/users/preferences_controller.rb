# frozen_string_literal: true

module Users
  class PreferencesController < ApplicationController
    def show
      render json: Current.user.preferences.to_json
    end

    def update; end
  end
end
