class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @content = Content.find(params[:content_id])
    @comments = @content.comments.includes(:user)
    if @comment.save
      ActionCable.server.broadcast 'comment_channel', content: @comment, name: @comment.user.name, time: @comment.created_at.strftime("%Y/%m/%d %H:%M:%S"), id: @content.id
    else
      # @content = @comment.content
      # @comments = @content.comments
      render "contents/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, content_id: params[:content_id])
  end

end
