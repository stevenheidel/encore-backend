class DashboardController < ActionController::Base
  layout "demo"

  def facebook_users
    @users = User.all.order("created_at DESC")
  end
end