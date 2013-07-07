require 'sidekiq/web'

EncoreBackend::Application.routes.draw do
  # API Routes
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create] do
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
    get '/api', :to => redirect('https://relishapp.com/encore/backend/docs/api/api')
  end
end
