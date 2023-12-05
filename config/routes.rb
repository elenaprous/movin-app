Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}

  root to: "pages#home"
  get '/preferences', to: 'pages#preferences'
  patch '/preferences/edit/:user_id', to: 'pages#edit_preferences', as: :preferences_edit

  get "up" => "rails/health#show", as: :rails_health_check

  resources :searches, only: [:index, :show] do
    member do
      get :info
    end
  end
end
