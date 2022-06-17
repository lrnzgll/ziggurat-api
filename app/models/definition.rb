# frozen_string_literal: true

class Definition < ApplicationRecord
  validates :body, presence: true

  belongs_to :expression
end
