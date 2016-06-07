Rails.application.routes.draw do
  root 'home#index'

  devise_for :users,
             defaults: { format: :json },
             skip: [:registrations, :sessions]
  as :user do
    post '/registrations' => 'registrations#create', as: :user_registration
    post '/login' => 'sessions#create', as: :user_session
    post '/authentications/:provider' => "registrations#authentications"
  end

  resources :spaces do
    member do
      post :images
    end
  end
  resources :space_types
  resources :amenities

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
