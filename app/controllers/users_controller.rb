class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  	@items = current_user.items
  end

  def top
  end

  def about
  end

  protected

  def genre_params
  	params.require(:user).permit(:name)
  end

end
