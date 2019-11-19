class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: :index
  def index
    # @restaurants = Restaurant.all
    @restaurants = policy_scope(Restaurant) # we shuffled the code around to have the scope inside the policy
  end

  def show
  end

  def new
    @restaurant = Restaurant.new
    authorize @restaurant # authorizing the restaurant for the new action
  end

  def edit
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user = current_user
    authorize @restaurant # authorizing the restaurant for the create action
    if @restaurant.save
      redirect_to @restaurant, notice: 'Restaurant was successfully created.'
    else
      render :new
    end
  end

  def update
    if @restaurant.update(restaurant_params)
      redirect_to @restaurant, notice: 'Restaurant was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @restaurant.destroy
    redirect_to restaurants_url, notice: 'Restaurant was successfully destroyed.'
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant # authorizing the restaurant for the show, edit, update, and destroy actions
  end

  def restaurant_params
    params.require(:restaurant).permit(:name)
  end
end
