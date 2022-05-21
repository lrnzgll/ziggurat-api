Rails.application.routes.draw do
  root to: 'home#main'

  namespace :users do
    resource :preferences, only: [:update, :show]
  end
end
