class UsersController < ApplicationController
  before_action :set_bookings, only: %i[show]

  def show
    @user = User.find(params[:id])

    # TODO: add boat infos in the request
    @bookings
    @sum

  end

  private

  def set_bookings
    @bookings = Booking.where(user_id: current_user.id)
    @sum = Booking.where(user_id: current_user.id).count
  end
end
