# frozen_string_literal: true

class UserPreference < ApplicationRecord
  belongs_to :user

  validates :periodicity, presence: true
end
