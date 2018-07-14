class RestaurantsController < ApplicationController

  before_action :authenticate_user!

  def index
    @restaurants = Restaurant.includes(:category).page(params[:page]).per(9)
    @categories = Category.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @comment = Comment.new
  end

  def feeds
    @recent_restaurants = Restaurant.includes(:category).order(created_at: :desc).limit(10)
    @recent_comments = Comment.includes(:user, :restaurant).order(created_at: :desc).limit(10)
  end

  def dashboard
    @restaurant = Restaurant.find(params[:id])
  end

  def favorite
    @restaurant = Restaurant.find(params[:id])
    @restaurant.favorites.create!(user: current_user)
    redirect_back(fallback_location: root_path)
  end

  def unfavorite
    @restaurant = Restaurant.find(params[:id])
    favorites = Favorite.where(restaurant: @restaurant, user: current_user)
    favorites.destroy_all
    redirect_back(fallback_location: root_path)
  end

  def like
    @restaurant = Restaurant.find(params[:id])
    @restaurant.likes.create!(user: current_user)
    redirect_back(fallback_location: root_path)
  end  

  def unlike
    @restaurant = Restaurant.find(params[:id])
    likes = Like.where(restaurant: @restaurant, user: current_user)
    likes.destroy_all
    redirect_back(fallback_location: root_path)
  end   

  def ranking
    @rank_restaurants = Restaurant.includes(:category).order(favorite_count: :desc).limit(10)
  end


end
