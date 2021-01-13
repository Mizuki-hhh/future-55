class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to content_path(@comment.content)
    else
      @content = @comment.content
      @comments = @content.comments
      render 'contents/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, content_id: params[:content_id])
  end
end
