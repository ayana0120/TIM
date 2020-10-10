class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
    @limit_items = Item.limit(5).order("exp IS NULL ASC").includes(:genre)
    @genres = Genre.all
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items - @genre.items.all.includes(:genre)
    else
      @new_items = Item.all.includes(:genre).order(id: :desc)
    end
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
  end

  def top
    @resource = User.new
  end

  def about
  end

  protected

  def genre_params
  	params.require(:user).permit(:name)
  end

  def search_params
    params.require(:q).permit(:name_cont)
  end

end
