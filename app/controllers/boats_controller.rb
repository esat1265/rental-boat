class BoatsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @boats = Boat.all

    if params[:search].present?
      if params[:search][:start_date].present? && params[:search][:end_date].present?
        start_date = Date.parse(params[:search][:start_date])
        end_date = Date.parse(params[:search][:end_date])
        boat_name = params[:search][:boat_name]
        @boats = @boats.available(start_date, end_date, boat_name)
      elsif params[:search][:boat_name].present?
        boat_name = params[:search][:boat_name]
        @boats = @boats.where("name ILIKE ?", "%#{boat_name}%")
      end

      sort_boats(params[:search]) #
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

  def sort_boats(search_params)
    case search_params[:sort_price]
    when 'price_asc'
      @boats = @boats.order(price_per_day: :asc)
    when 'price_desc'
      @boats = @boats.order(price_per_day: :desc)
    end
    if ['rating_asc', 'rating_desc'].include?(search_params[:sort_rating])
      @boats = @boats.sort { |boat_1, boat_2|
        avg_1 = Review.where(booking: boat_1.bookings).average(:rating) || 0
        avg_2 = Review.where(booking: boat_2.bookings).average(:rating) || 0

        avg_1 - avg_2
      }
      @boats.reverse! if search_params[:sort_rating] == 'rating_desc'
    end

  end

  def boat_params
    params.require(:boat).permit(:name, :description, :price_per_day, :year_production, :user_id, photos: [])
  end

  def search_params
    params.require(:search).permit(:boat_name, :start_date, :end_date, :sort_price, :sort_rating)
  end
end
