class API < Grape::API
  format :json
  prefix 'api'
  version 'v1'

  namespace :facebook do 
    desc "Posts Facebook login info."
    post :login do
      p env['action_dispatch.request.request_parameters']
      p params
      p params[:oauth]
    end
  end
end