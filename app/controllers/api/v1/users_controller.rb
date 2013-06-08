class Api::V1::UsersController < Api::V1::BaseController
  def create
    # Take Facebook login info and either update or create new user
    user = User.where(:facebook_uuid => params[:facebook_id])
    if user.any?
      user = user.first
    else
      user = User.new
      user.facebook_uuid = "1651770074"
    end

    user.oauth_string = params[:oauth]
    user.oauth_expiry = params[:expiration_date]
    user.save

    render :text => "success"
  end
end