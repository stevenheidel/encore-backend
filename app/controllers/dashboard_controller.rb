class DashboardController < ActionController::Base
  def facebook_users
    @users = User.all.order("created_at DESC")

    @num_users = @users.count
    @num_events = @users.inject(0) { |mem, var| mem += var.events_count }

    @events_per_user = @num_events.to_f / @num_users
    @excluding_zero  = @num_events.to_f / User.where("events_count > ?", 0).count
  end
end