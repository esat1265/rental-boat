class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def new
    @booking = Booking.find(params[:booking_id])
    @review = @booking.build_review
  end


  def create
    @booking = Booking.find(params[:booking_id])
    @review = @booking.build_review(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to boats_path(@booking.boat_id), notice: 'Review was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
