Rails.application.routes.draw do
  devise_for :users
  root 'games#index'
  resource :games do
    post 'join'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
