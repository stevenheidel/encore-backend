class Api::V1::UsersController < Api::V1::BaseController
  def create
    # Take Facebook login info and either update or create new user
    user = User.find_or_create_by(facebook_id: params[:facebook_id])
    user.oauth_string = params[:oauth]
    user.oauth_expiry = params[:expiration_date]
    user.name = params[:name]
    user.save

    render 'api/v1/base/result.json', locals: {result: 'success'}
  end
end