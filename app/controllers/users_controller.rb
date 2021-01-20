class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @contents = @user.contents.order("created_at DESC")

    if user_signed_in?
      favorites = Favorite.where(user_id: current_user.id).pluck(:content_id) # ログイン中のユーザーのお気に入りのpost_idカラムを取得
      @favorite_contents = Content.find(favorites)
    end
  end
  
end
