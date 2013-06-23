class Api::V1::PostsController < Api::V1::BaseController
  def index
    @posts = Concert.find_by(songkick_uuid: params[:concert_id]).posts
  end

  # upload a user photo to the time_capsule
  def create
    @concert = Concert.find_by(songkick_uuid: params[:concert_id])

    @user_photo = @concert.user_photos.new
    @user_photo.photo = params[:file]

    render 'api/v1/base/result.json', locals: {result: 'success'}
  end

  # TODO
  def popular

  end
end