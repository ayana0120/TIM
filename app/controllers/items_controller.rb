class ItemsController < ApplicationController
  before_action :set_item, only:[:edit, :show, :update, :update]
  before_action :authenticate_user!

  def index
    if params[:genre_id]
      @genre = current_user.genres.find(params[:genre_id])
      @items = current_user.genres.items.all.includes(:genre)
    else
      @items = current_user.items.all.includes(:genre)
    end
  end

  def new
    @item = current_user.items.new
    @genre = current_user.genres.new
  end

  def create
    @item = current_user.items.new(item_params)
    if @item.save
      redirect_to item_path(@item)
    else
      render :new
    end
  end

  def edit
  end

  def show
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to items_path
    else
      render :index
    end
  end

  def search
    @q = current_user.items.ransack(params[:q])
    @items = @q.result(distinct: true)
  end

  protected

  def item_params
    params.require(:item).permit(:name, :image, :quantity, :exp, :memo, :genre_id )
  end

  def genre_params
    params.require(:genre).permit(:name)
  end

  def set_item
    @item = current_user.items.find(params[:id])
  end

end
