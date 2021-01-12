class ContentsController < ApplicationController
  before_action :set_content, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:index, :show]
  # load_and_authorize_resource

  def index
    @contents = Content.includes(:user).order("created_at DESC")
  end

  def new
    @content = Content.new
  end

  def create
    @content = Content.new(content_params)
    if @content.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    unless @content.user_id == current_user.id
      redirect_to root_path
    end
  end

  def update
    if @content.update(content_params)
      redirect_to content_path(@content.id)
    else
      render :edit
    end
  end

  private

  def content_params
    params.require(:content).permit(:title, :image_content, :video_content, :overview, :writing, :source).merge(user_id: current_user.id)
  end

  def set_content
    @content = Content.find(params[:id])
  end
end
