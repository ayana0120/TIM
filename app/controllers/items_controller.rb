class ItemsController < ApplicationController
  before_action :set_item, only:[:edit, :show, :update, :update]

  def index
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.all.includes(:genre)
    else
      @items = Item.all.includes(:genre)
    end
  end

  def new
    @item = Item.new
    @genre = Genre.new
  end

  def create
    @item = Item.new(item_params)
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
    if @genre.update(genre_params)
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
    @search = Item.ransack(params[:search])
    @items = @search.result(distinct: true)
  end

  protected

  def item_params
    params.require(:item).permit(:name, :image, :quantity, :exp, :memo, :genre_id )
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
