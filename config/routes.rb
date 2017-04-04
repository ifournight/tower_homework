Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :activities, only: [:index]

  resources :create_todos, only: [:create]

  resources :complete_todos, only: [:create]

  namespace :api do
    namespace :v1 do
      resources :create_todos, only: [:create]
    end
  end

  get 'sign_in', to: 'sign_in#new'
  post 'sign_in', to: 'sign_in#create'

  root 'home#index'
end
