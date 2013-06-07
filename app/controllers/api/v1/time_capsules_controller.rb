class Api::V1::TimeCapsulesController < Api::V1::BaseController
  def show
    @posts = Concert.find(params[:concert_id]).time_capsule.posts
  end

  # TODO
  def popular

  end
end