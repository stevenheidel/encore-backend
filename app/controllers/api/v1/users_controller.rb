class Api::V1::UsersController < Api::V1::BaseController
  def create
    # Take Facebook login info and either update or create new user
    @user = User.find_or_create_by(facebook_id: params[:facebook_id])
    @user.oauth_string = params[:oauth]
    @user.oauth_expiry = params[:expiration_date]
    @user.name = params[:name]
    @user.save!

    # SMELL: should just redirect to the show action
    render "api/v1/users/show.json"
  end

  def show
    @user = User.get(params[:facebook_id])
  end
end