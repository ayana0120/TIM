class ItemsController < ApplicationController
  before_action :set_item, only:[:edit, :show, :update, :destroy,
  :quantity_decreases, :quantity_increases]
  before_action :set_search_box, only:[:index, :search]
  before_action :authenticate_user!

  def index
    if params[:genre_id]
      @genre = current_user.genres.find(params[:genre_id])
      @items = @genre.items.all.includes(:genre)
    else
      @items = current_user.items.all.order("updated_at DESC").includes(:genre)
    end
  end

  def new
    @item = current_user.items.new
    @genre = current_user.genres.new
  end

  def create
    @item = current_user.items.new(item_params)
    @new_item = current_user.items.find_by(name: @item.name)
    if @new_item.present? &&
      @new_item.name == @item.name &&
      @new_item.genre_id == @item.genre_id &&
      @new_item.exp == @item.exp &&
      @new_item.memo == @item.memo &&
      @new_item.image_id == @item.image_id
      @new_item.quantity += @item.quantity
      @new_item.update(quantity: @new_item.quantity)
      redirect_to items_path
    else
      if @item.save
        redirect_to item_path(@item)
      else
        render :new
      end
    end
  end

  def edit
  end

  def show
  end

  def update
    if @item.update(item_params)
      redirect_to items_path
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
  end

  def quantity_decreases
    @item.quantity -= 1
    @item.update(add_item_params)
    redirect_back fallback_location: root_path
  end

  def quantity_increases
    @item.quantity += 1
    @item.update(add_item_params)
    redirect_back fallback_location: root_path
  end

  protected

  def item_params
    params.require(:item).permit(:name, :image, :quantity, :exp, :memo, :genre_id )
  end

  def add_item_params
    params.permit(:quantity)
  end

  def genre_params
    params.require(:genre).permit(:name)
  end

  def set_item
    @item = current_user.items.find(params[:id])
  end

  def set_search_box
    @q = current_user.items.ransack(params[:q])
    @items = @q.result(distinct: true)
  end

end
