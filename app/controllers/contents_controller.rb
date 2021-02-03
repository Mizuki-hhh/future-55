class ContentsController < ApplicationController
  before_action :set_category, except: [:show]
  before_action :category_parent_array, only: [:new, :create, :edit, :update]
  before_action :set_content, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :search]
  # load_and_authorize_resource

  def index
    @contents = Content.includes(:user).order("created_at DESC")
    @parents = Category.where(ancestry: nil)
  end

  def new
    @content = Content.new
    if current_user.student?
      redirect_to controller: :contents, action: :index
    end
  end

  def create
    @category_children = Category.find_by(id: params[:category_id])
    @content = Content.new(content_params)
    if @content.save
      flash[:notice] = 'コンテンツの投稿が完了しました'
      redirect_to root_path
    else
      flash[:alert] = 'すべて記入して下さい（画像か動画はどちらかまたは両方を添付して下さい）'
      render :new
      # redirect_to controller: :contents, action: :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @content.comments.includes(:user).order("created_at DESC")
    @category_id = @content.category_id
    @category_parent = Category.find(@category_id).parent
    @category_child = Category.find(@category_id)
  end

  def edit
    child_category = @content.category
    @category_children_array = []
    Category.where(ancestry: child_category.ancestry).each do |children|
      @category_children_array << children
    end
    unless @content.user_id == current_user.id
      redirect_to root_path
    end
  end

  def update
    if @content.update(content_params)
      redirect_to content_path(@content.id)
    else
      redirect_to controller: :contents, action: :edit
    end
  end

  def destroy
    if current_user.id == @content.user_id
      if @content.destroy
        redirect_to root_path
      else
        render :show
      end
    end
  end
  
  def get_category_children
    @category_children = Category.find_by(name: "#{params[:parent_id]}", ancestry: nil).children
  end

  def search
    @contents = Content.search(params[:keyword]).order("created_at DESC")
  end
  

  private

  def content_params
    params.require(:content).permit(:title, :image_content, :video_content, :overview, :writing, :source, :category_id).merge(user_id: current_user.id)
  end

  def set_content
    @content = Content.find(params[:id])
  end

  def set_category
    @category_parent_array = Category.where(ancestry: nil)
  end

  def category_parent_array
    @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end

end
