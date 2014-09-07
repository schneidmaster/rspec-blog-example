Rails.application.routes.draw do
  root 'welcome#index'

  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :articles do
    resources :comments
  end
  resources :users, only: [:new, :create]

  namespace :api do
    namespace :v1 do
      resources :articles, only: [:index, :show]
    end
  end
end
