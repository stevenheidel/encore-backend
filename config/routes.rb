require 'sidekiq/web'

EncoreBackend::Application.routes.draw do
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  namespace :api do
    namespace :v1 do
      get 'ping' => 'ping#ping'
    end
  end

  get 'locations' => 'locations#index'

  resources :time_capsules
  get 'time_capsules/:id/populated' => 'time_capsules#populated'

  mount Sidekiq::Web => '/sidekiq'
end
