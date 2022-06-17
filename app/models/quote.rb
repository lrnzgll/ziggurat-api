# frozen_string_literal: true

class Quote < ApplicationRecord
  validates :body, presence: true

  belongs_to :expression
end
