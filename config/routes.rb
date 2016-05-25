Rails.application.routes.draw do
  devise_for :users,
             defaults: { format: :json },
             skip: [:registrations, :sessions],
             controllers: { sessions: :sessions, registrations: :registrations }
  as :user do
    post '/registrations' => 'registrations#create', as: :user_registration
    post '/login' => 'sessions#create', as: :user_session
  end

  resources :spaces
  resources :space_types
  resources :amenities

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
