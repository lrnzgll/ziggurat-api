# frozen_string_literal: true

class User < ApplicationRecord
  validates :auth_id, presence: true
end
