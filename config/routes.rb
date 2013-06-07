require 'sidekiq/web'

EncoreBackend::Application.routes.draw do
  # API Routes
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create] do
        resources :concerts, only: [:index, :create]
      end

      resources :concerts, only: [:index, :show] do
        resources :users, only: []
        resource :time_capsule, only: [:show]

        collection do
          get :popular
          get :search
        end
      end

      resources :artists, only: [] do
        collection do
          get :search
        end
      end
    end
  end

  # Rails Admin
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  # Sidekiq
  mount Sidekiq::Web => '/sidekiq'

  # Testing Routes
  get 'locations' => 'locations#index'

  resources :time_capsules
  get 'time_capsules/:id/populated' => 'time_capsules#populated'
end
