class Api::V1::PostsController < Api::V1::BaseController
  def index
    # SMELL: simply shuffling the posts here
    @posts = Event.find_or_create_from_lastfm(params[:event_id]).posts.shuffle(random: Random.new(1))
  end

  # upload a user photo to the time_capsule
  def create
    @event = Event.get(params[:event_id])

    @user_photo = @event.user_photos.new
    @user_photo.photo = params[:image]
    @user_photo.user = User.get(params[:facebook_id])
    @user_photo.save

    render 'api/v1/base/result.json', locals: {result: 'success'}
  end

  def flag
    @post = Post.find(params[:id])
    @post.add_flag(params[:flag], params[:facebook_id])

    render 'api/v1/base/result.json', locals: {result: 'success'}
  end
end