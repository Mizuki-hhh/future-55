class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @contents = @category.contents.order("created_at DESC")
  end

end
