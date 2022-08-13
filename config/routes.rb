# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#main'

  resource :user, only: [:show]

  namespace 'users' do
    resource :preferences, only: [:show, :create]
    resources :notifications, only: :index
  end

  resources :expressions
end
