class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  	@items = Item.all.includes(:genre)
    @limit_items = Item.limit(5).order("exp").includes(:genre)
    @genres = Genre.all
  end

  def top
  end

  def about
  end

  protected

  def genre_params
  	params.require(:user).permit(:name)
  end

end
