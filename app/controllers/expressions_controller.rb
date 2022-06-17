# frozen_string_literal: true

class ExpressionsController < ApplicationController
  def index
    @expressions =
      Expression
      .eager_load(:definitions, :quotes)
  end
end
