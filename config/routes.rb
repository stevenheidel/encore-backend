EncoreBackend::Application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'ping' => 'ping#ping'
    end
  end

  get 'locations' => 'locations#index'
end
