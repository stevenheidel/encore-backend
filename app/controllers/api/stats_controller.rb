class Api::StatsController < ActionController::Base
  def users
    result = CSV.generate do |csv|
      csv << ["Date", "Users"]

      20.downto(0) do |x|
        date = Date.today - x.days
        user_count = User.where(:created_at.lte => date).count

        csv << [date.strftime("%Y%m%d"), user_count]
      end
    end

    send_data result
  end
end