class DashboardController < ActionController::Base
  layout "demo"

  def facebook_users
    @users = User.all.order("updated_at DESC")
  end
end