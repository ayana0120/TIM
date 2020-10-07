class GenresController < ApplicationController
	before_action :set_genre, only: [:update, :destroy]

  def index
    @newgenre = Genre.new
  	@genres = Genre.all
    @user = current_user
  end

  def create
  	@genre = Genre.new(genre_params)
  	if @genre.save
  	  redirect_to genres_path
  	else
  	  render :index
  	end
  end

  def update
  	if @genre.update(genre_params)
  	  redirect_to genres_path
  	else
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
  	@genre = Genre.find(params[:id])
  end

end
