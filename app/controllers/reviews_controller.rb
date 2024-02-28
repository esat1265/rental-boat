class ReviewsController < ApplicationController
  before_action :set_booking, only: [:new, :create]

  def new
    @review = Review.new
    @bookings = current_user.bookings
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    if @review.save
      redirect_to reviews_path, notice: 'Review was successfully created.'
    else
      @bookings = current_user.bookings
      render :new
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end


  def review_params
    params.require(:review).permit(:content, :rating, :booking_id)
  end
end
