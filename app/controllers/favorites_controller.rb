class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_variables, only: [:favorite, :unfavorite]

  def favorite
    favorite = current_user.favorites.new(content_id: @content.id)
    favorite.save
  end

  def unfavorite
    favorite = current_user.favorites.find_by(content_id: @content.id)
    favorite.destroy
  end

  private

  def set_variables
    @content = Content.find(params[:content_id])
    @id_name = "favorite-link-#{@content.id}"
    @id_heart = "heart-#{@content.id}"
  end

end
