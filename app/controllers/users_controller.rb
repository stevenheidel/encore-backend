class UsersController < ApplicationController
  def index
    @users = User.all

    @users.map {|u| u.name = name_from_facebook_id(u.facebook_uuid)}
  end

  def show
    @user_id = User.find(params[:id]).facebook_uuid
  end

  private

  def name_from_facebook_id(id)
    ActiveSupport::JSON.decode(Faraday.get("https://graph.facebook.com/#{id}").body)['name']
  end
end