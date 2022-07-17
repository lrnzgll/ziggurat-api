# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#main'

  resource :user
  resources :expressions
  resources :notifications
end
