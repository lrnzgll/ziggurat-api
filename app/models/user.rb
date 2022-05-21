# frozen_string_literal: true

class User < ApplicationRecord
  has_one :user_preference, dependent: :destroy

  validates :auth_id, presence: true

  def preferences
    user_preference || create_user_preference
  end
end
