class PostsController < ApplicationController
  def show
    @post = Post.get(params[:id])
    @event = @post.event
  end
end