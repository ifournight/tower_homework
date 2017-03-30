Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :activities, only: [:index]

  namespace :api do
    namespace :v1 do
      resources :create_todos, only: [:create]
    end
  end
end
