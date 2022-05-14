# frozen_string_literal: true

class HomeController < ApplicationController
  def main
    render json: {message: 'Hello, World!'}
  end
end
