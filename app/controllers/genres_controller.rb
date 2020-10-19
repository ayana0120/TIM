class GenresController < ApplicationController
	before_action :set_genre, only: [:update, :destroy]
  before_action :authenticate_user!

  def index
    @genre = current_user.genres.new
  	@genres = current_user.genres.all
    @user = current_user
  end

  def create
  	@genre = current_user.genres.new(genre_params)
    @new_genre = current_user.genres.find_by(name: @genre.name)
    if @new_genre.present? &&
      @new_genre.name == @genre.name
      flash[:notice] = "すでに存在するジャンルです"
      redirect_back fallback_location: root_path
    else
    	if @genre.save
    	  redirect_back fallback_location: root_path
    	else
        @genres = current_user.genres.all
    	  render :index
    	end
    end
  end

  def update
  	if @genre.update(genre_params)
  	  redirect_to genres_path
  	else
      @genres = current_user.genres.all
  	  render :index
  	end
  end

  def destroy
  	if @genre.destroy
  	  redirect_to genres_path
  	else
  	  render :index
  	end
  end

  protected

  def genre_params
  	params.require(:genre).permit(:name)
  end

  def set_genre
  	@genre = current_user.genres.find(params[:id])
  end

end
