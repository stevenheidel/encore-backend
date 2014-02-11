class Api::StatsController < ActionController::Base
  def users_time
    result = CSV.generate do |csv|
      csv << ["Date", "Users"]

      20.downto(0) do |x|
        date = Date.today - x.days
        user_count = User.where("created_at <= ?", date + 1.days).count

        csv << [date.strftime("%Y%m%d"), user_count]
      end

      csv << ["Cumulative", 1]
    end

    send_data result
  end

  def users_gauge
    result = CSV.generate do |csv|
      csv << ["Users", "Target"]
      csv << [User.count, 10000]
    end

    send_data result
  end

  def posts_pie
    result = CSV.generate do |csv|
      csv << ["Flickr", "Instagram", "Youtube"]
      csv << [Post.flickr.count, Post.instagram.count, Post.youtube.count]
    end

    send_data result
  end
end