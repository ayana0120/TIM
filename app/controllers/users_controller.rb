class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
    @limit_items = Item.limit(5).order("exp").includes(:genre)
    @genres = Genre.all
    #検索結果表示のif文考える
    @search = Item.ransack(params[:search])
    @items = @search.result(distinct: true)
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items - @genre.items.all.includes(:genre)
    else
      @items = Item.all.includes(:genre).order(id: :desc)
    end
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
