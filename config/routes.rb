Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root 'loggedin#index', as: :authenticated_root
  end

  root 'loggedout#index'
  resources :games
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
