require 'sidekiq/web'
require 'sidekiq_status/web'

EncoreBackend::Application.routes.draw do
  # API Routes
  # TODO: secure this with some sort of shared key
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :show] do
        resources :events, only: [:index, :create, :destroy]
      end

      resources :events, only: [:index, :show] do
        resources :users, only: []
        resources :posts, only: [:index, :create]

        collection do
          get :past
          get :today
          get :future
        end

        member do
          get :populating
        end
      end

      resources :artists, only: [] do
        resources :events, only: [] do
          collection do
            get :past
            get :future
          end
        end

        collection do
          get :search
          get :combined_search
        end
      end

      resources :posts, only: [] do
        member do
          post :flag
        end
      end
    end
  end

  # Public routes
  resources :events, only: [:show]
  resources :posts, only: [:show]

  # Private routes TODO: Secure this from outsiders
  scope '/private' do
    # Demo webapp
    namespace :demo do
      root to: redirect('/private/demo/users')
      resources :users, only: [:show, :index]
      resources :events, only: [:show, :index]
    end

    # Rails Admin
    devise_for :admins, :path_prefix => '/private'
    mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

    # Sidekiq
    mount Sidekiq::Web => '/sidekiq'

    # Documentation
    get '/api', to: redirect('https://relishapp.com/encore/backend/docs/api?token=EVAxzeK6EqNFbhsX3s7C')
  end
end
