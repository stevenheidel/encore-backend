class Api::V1::PostsController < Api::V1::BaseController
  def index
    @posts = Concert.find(params[:concert_id]).posts
  end

  # upload a user photo to the time_capsule
  def create
    @concert = Concert.find(params[:concert_id])

    @user_photo = @concert.user_photos.new
    @user_photo.photo = params[:file]

    render :text => '{"response":"success"}'
  end

  # TODO
  def popular

  end
end