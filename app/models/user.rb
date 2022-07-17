# frozen_string_literal: true

class User < ApplicationRecord
  #  has_one :user_preference, dependent: :destroy
  has_many :notifications, as: :recipient, dependent: :destroy

  attr_accessor :email

  after_create_commit :new_user_notification

  validates :auth_id, presence: true
  validates :name, presence: true

  def preferences
    user_preference || create_user_preference
  end

  private

  def new_user_notification
    NewUserNotification.with(user: self).deliver(self)
  end
end
