class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = current_user
    @restaurant_a = Restaurant.all
    @commented_restaurants = @user.restaurants
    @commented_restaurants_nd = @commented_restaurants.ids.uniq

    @commented_restaurants_number = @commented_restaurants.ids.uniq.length
    @commented_restaurants.each do |restaurant|

    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update_attributes(user_params)
    redirect_to user_path(@user)
    flash[:notice] = "Your user profile was successfully updated!"
  end

  def user_params
    params.require(:user).permit(:name, :intro, :avatar)
  end

end
