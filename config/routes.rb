Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json }, controllers: {
    sessions: :sessions,
    registrations: :registrations
  }

  devise_scope :user do
    # post "/registrations" => "devise/registrations#create"
    post "/registrations" => "registrations#create"
  end


  resources :spaces
  resources :space_types
  resources :amenities

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
