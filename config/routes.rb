Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'games#index'
  get 'challenge', to: 'static_pages#challenge'
  resources :games do
    post 'join'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
