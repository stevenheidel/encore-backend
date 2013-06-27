class PostsController < ApplicationController
  def show
    # TODO: not for multiple models!
    @post = InstagramPhoto.find(params[:id])
    @concert = @post.concert
  end
end