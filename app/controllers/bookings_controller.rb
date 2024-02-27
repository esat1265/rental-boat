class BookingsController < ApplicationController
  before_action :set_boat, only: %i[new create]

  def new
    @boat_to_book = @boat
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.boat = @boat
    debugger
    if @booking.save
      redirect_to boat_path(@boat)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_boat
    @boat = Boat.find(params[:boat_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :price_per_day, :year_production, :photo)
  end
end
