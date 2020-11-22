class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @user = current_user
    @limit_items = current_user.items.limit(5).order("exp IS NULL, exp ASC").includes(:genre)
    @genres = current_user.genres.all
    if params[:genre_id]
      @genre = current_user.genres.find(params[:genre_id])
      @items - current_user.genres.items.all.includes(:genre)
    else
      @new_items = current_user.items.all.includes(:genre).order(id: :desc).limit(5)
    end
    @q = current_user.items.ransack(params[:q])
    @items = @q.result(distinct: true)
  end

  def top
    @user = User.new
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
