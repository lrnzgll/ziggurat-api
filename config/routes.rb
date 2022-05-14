Rails.application.routes.draw do
  root to: 'home#main'

  namespace :users do
    resource :preferences, only: [:new, :create] do
      get '/current', to: 'preferences#current', as: :current
    end
  end
end
