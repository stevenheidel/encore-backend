class Api::V1::PostsController < Api::V1::BaseController
  def index
    @posts = Event.get(params[:concert_id]).posts
  end

  # upload a user photo to the time_capsule
  def create
    @event = Event.get(params[:concert_id])

    @user_photo = @concert.user_photos.new
    @user_photo.photo = params[:image]
    @user_photo.user = User.get(params[:facebook_id])
    @user_photo.save

    render 'api/v1/base/result.json', locals: {result: 'success'}
  end

  # TODO
  def popular

  end
end