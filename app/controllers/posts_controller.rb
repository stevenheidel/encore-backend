class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @event = @post.event
  end
end