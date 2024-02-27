class BoatsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:search].present?
      @boats = Boat.all.limit(3)
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

  def search
    available_start_date = params[:search][:start_date]
    available_end_date = params[:search][:end_date]
  end


  private
  def boat_params
    params.require(:boat).permit(:name, :description, :price_per_day, :year_production, :user_id, photos: [])
  end

end
