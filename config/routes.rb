EncoreBackend::Application.routes.draw do
  mount API => '/'

  get 'locations' => 'locations#index'
end
