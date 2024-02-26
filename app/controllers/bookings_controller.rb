class BookingsController < ApplicationController
  before_action :set_boat, only: %i[new create]

  def new
    @boatWanted = @boat
    @booking = Booking.new
  end

  def create

  end

  private

  def set_boat
    @boat = Boat.find(params[:boat_id])
  end
end
