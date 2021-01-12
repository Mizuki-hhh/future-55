class ContentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  # load_and_authorize_resource

  def index
    @contents = Content.includes(:user).order("created_at DESC")
  end

  def new
    @content = Content.new
    if current_user.student?
      redirect_to root_path
    end
  end

  def create
    @content = Content.new(content_params)
    if @content.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def content_params
    params.require(:content).permit(:title, :image_content, :video_content, :overview, :writing, :source).merge(user_id: current_user.id)
  end
end
