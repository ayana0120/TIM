class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:top, :about]
  before_action :set_user, only:[:show, :edit, :update, :destroy]

  def show
    @limit_items = current_user.items.limit(5).order("exp IS NULL ASC").includes(:genre)
    @genres = current_user.genres.all
    if params[:genre_id]
      @genre = current_user.genres.find(params[:genre_id])
      @items - current_user.genres.items.all.includes(:genre)
    else
      @new_items = current_user.items.all.includes(:genre).order(id: :desc)
    end
    @q = current_user.items.ransack(params[:q])
    @items = @q.result(distinct: true)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :end
    end
  end

  def destroy
    if @user.destroy
      redirect_to root_path
    else
      render :edit
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

  def set_user
    @user = current_user
  end
end
