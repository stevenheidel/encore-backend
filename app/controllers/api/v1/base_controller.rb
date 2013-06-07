class Api::V1::BaseController < ActionController::Base # or ActionController::Metal later
  respond_to :json
end