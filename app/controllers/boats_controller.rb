class BoatsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:search].present?
      start_date = Date.parse(params[:search][:start_date])
      end_date = Date.parse(params[:search][:end_date])
      @boats = Boat.available(start_date, end_date)
    else
      @boats = Boat.all
    end
  end

  def new
    @boat = Boat.new
  end

  def show
    @boat = Boat.find(params[:id])
  end

  def create
    @boat = Boat.new(boat_params)
    if @boat.save!
      redirect_to boat_path(@boat)
    else
      render :new, status: :unprocessable_entity
    end
  end


  private
  def boat_params
    params.require(:boat).permit(:name, :description, :price_per_day, :year_production, :user_id, photos: [])
  end

end
