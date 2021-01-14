class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @contents = @user.contents.order("created_at DESC")
  end
end
