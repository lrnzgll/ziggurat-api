# frozen_string_literal: true

class User < ApplicationRecord
  has_many :notifications, as: :recipient, dependent: :destroy
  has_many :user_preferences, dependent: :destroy

  attr_accessor :email

  after_create_commit :new_user_notification

  validates :auth_id, presence: true
  validates :name, presence: true

  def preferences
    user_preferences.last || default_user_preferences
  end

  private

  def default_user_preferences
    user_preferences.create(periodicity: 'weekly')
  end

  def new_user_notification
    NewUserNotification.with(user: self).deliver(self)
  end
end
