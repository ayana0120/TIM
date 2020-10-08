class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
    @limit_items = Item.limit(5).order("exp").includes(:genre)
    @genres = Genre.all
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items - @genre.items.all.includes(:genre)
    else
      @items = Item.all.includes(:genre).order(id: :desc)
    end
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
