# frozen_string_literal: true

module Users
  class PreferencesController < ApplicationController
    def new
    end

    def create
    end

    def current
      render json: Current.user.auth_id.to_json
    end
  end
end
