# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = Current.user
  end
end
