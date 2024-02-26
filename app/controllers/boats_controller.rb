class BoatsController < ApplicationController
  def index
    @boats = Boat.all
  end

  def new
    @boat = Boat.new
  end

  def create
    @boat = Boat.new(boat_params)
    if @boat.save
      redirect_to boat_path(@boat)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def boat_params
    params.require(:boat).permit(:name, :description, :price_per_day, :year_production, :photo)

  def show
    @boat = Boat.find(params[:id])
  end
end
