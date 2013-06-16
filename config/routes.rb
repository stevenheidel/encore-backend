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
        resources :posts, only: [:index, :create]
      end

      resources :artists, only: [] do
        resources :concerts, only: [] do
          collection do
            get :past
          end
        end

        collection do
          get :search
        end
      end
    end
  end

  # Demo webapp
  root to: redirect('/users')
  resources :users

  # Rails Admin
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  # Sidekiq
  mount Sidekiq::Web => '/sidekiq'

  # Testing Routes
  get 'locations' => 'locations#index'
  resources :concerts
end
