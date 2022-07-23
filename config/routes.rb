# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#main'

  resource :user, only: [:show]

  namespace 'users' do
    resource :preferences, only: [:show, :create]
  end

  resources :expressions
  resources :notifications
end
