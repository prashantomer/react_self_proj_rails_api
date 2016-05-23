Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json }, controllers: {
    sessions: :sessions,
    registrations: :registrations
  }

  resources :spaces
  resources :space_types

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
