Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'static_pages#index'
  get 'team', to: 'static_pages#team'
  get 'lobby', to: 'static_pages#lobby'
  get 'privacy', to: 'static_pages#privacy'
  resources :games do
    post 'join'
  end
  resources :pieces, only: [:update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
