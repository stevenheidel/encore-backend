class Demo::UsersController < Demo::BaseController
  def index
    @users = User.all
  end

  def show
    @user_id = User.find(params[:id]).facebook_id
  end
end