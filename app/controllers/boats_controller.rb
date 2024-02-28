class BoatsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:search].present?
      if params[:search][:start_date].present? && params[:search][:end_date].present?
        start_date = Date.parse(params[:search][:start_date])
        end_date = Date.parse(params[:search][:end_date])
        boat_name = params[:search][:boat_name]
        @boats = Boat.available(start_date, end_date, boat_name)
      elsif params[:search][:boat_name].present?
        boat_name = params[:search][:boat_name]
        @boats = Boat.where("name ILIKE ?", "%#{boat_name}%")
      end
    else
      @boats = Boat.all
    end
  end

  def new
    @boat = Boat.new
  end

  def show
    @boat = Boat.find(params[:id])
    @bookings = @boat.bookings
    @reviews = Review.where(booking: @bookings)
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
