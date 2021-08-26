class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @user = current_user
    @genres = current_user.genres.all
    if @user.items.where.not(exp: nil).count >= 5
      # その日以降の期限順に5個取得
      @limit_items = @user.items.limit(5).where("exp >= ?",Date.today).order("exp IS NULL, exp").includes(:genre)
    else
      #nullを含んだ期限順に5個取得
      @limit_items = @user.items.limit(5).order("exp IS NULL, exp").includes(:genre)
    end
    # 既に期限の切れたアイテムの期限順に5個取得
    @expired_items = @user.items.limit(5).where("exp < ?",Date.today).order("exp IS NULL, exp").includes(:genre)
    # アイテム検索用
    @q = @user.items.ransack(params[:q])
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
