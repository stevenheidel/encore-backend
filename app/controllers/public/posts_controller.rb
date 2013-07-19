class Public::PostsController < Public::BaseController
  def show
    @post = Post.find(params[:id])
    @event = @post.event
  end
end