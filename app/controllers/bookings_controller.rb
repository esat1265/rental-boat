class BookingsController < ApplicationController
  before_action :set_boat, only: %i[new create]
  before_action :authenticate_user!, only: [:new, :create]
  before_action :authenticate_user!

  def index
    @bookings = current_user.bookings.includes(:boat)
  end


  def new
    @boat_to_book = @boat
    @booking = Booking.new
  end

  def create
    @boat_to_book = @boat
    @booking = Booking.new(booking_params)
    @booking.boat = @boat
    @booking.user_id = current_user.id
    # debugger
    if @booking.save
      redirect_to boats_path(@boat)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_boat
    @boat = Boat.find(params[:boat_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :total_amount, :comment)
  end
end
