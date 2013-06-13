class Api::V1::UsersController < Api::V1::BaseController
  def create
    # Take Facebook login info and either update or create new user
    p params

    user = User.where(:facebook_uuid => params[:facebook_id]).first_or_initialize
    user.oauth_string = params[:oauth]
    user.oauth_expiry = params[:expiration_date]
    user.save

    render :text => '{"response":"success"}'
  end
end