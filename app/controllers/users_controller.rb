class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = current_user
    # @restaurant_a = Restaurant.all
    restaurants = @user.restaurants
    commented_restaurants_nd = restaurants.ids.uniq
    @commented_restaurants = Restaurant.find(commented_restaurants_nd)
    @commented_restaurants_number = commented_restaurants_nd.length

    @favorite_restaurants = @user.favorited_restaurants
    @favorite_restaurants_nd = @user.favorited_restaurants.ids.length

    @followings = @user.followings.all
    @followings_nd = @user.followings.ids.length

    @followers = @user.followers.all
    @followers_nd = @user.followers.ids.length

  end

  def friend_list
    user = current_user
    all_friends = user.friends.all.ids + user.friendss.all.ids
    all_friends_q = all_friends.uniq
    @users = User.find(all_friends_q)
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
