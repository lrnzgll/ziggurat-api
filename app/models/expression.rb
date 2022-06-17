# frozen_string_literal: true

class Expression < ApplicationRecord
  validates :body, presence: true

  has_many :definitions, dependent: :destroy
  has_many :quotes, dependent: :destroy
end
