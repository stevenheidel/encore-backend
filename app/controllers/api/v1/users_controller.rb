class Api::V1::UsersController < Api::V1::BaseController
  # Take Facebook login info and either update or create new user
  def create
    p params

    # look up user by facebook_uuid

    # if found, update their oauth token

    # if not, make new user

    # render 'success' or something
  end
end