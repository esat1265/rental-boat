class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def new
    @booking = Booking.find(params[:booking_id])
    @review = @booking.build_review
  end


  def create
    @booking = Booking.find(params[:booking_id])
    @review = @booking.build_review(review_params)
    if @review.save
      redirect_to bookings_path, notice: 'Votre review a été créée avec succès.'
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
