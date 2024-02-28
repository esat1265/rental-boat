class Booking < ApplicationRecord
  belongs_to :boat
  belongs_to :user
  has_one :review

  after_save :calculate_amount

  validates :end_date, presence: { message: "End date can't be blank" }
  validates :start_date, presence: { message: "Start date can't be blank" }
  validate :end_date_after_start_date
  validate :no_overlapping_bookings

  private

  def calculate_amount
    return unless saved_change_to_end_date? && saved_change_to_start_date?

    total_amount = (end_date - start_date).to_i * boat.price_per_day
    self.update(total_amount: total_amount)
  end

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?
    errors.add(:end_date, "must be after start date") if end_date <= start_date
  end

  def no_overlapping_bookings
    return if start_date.blank? || end_date.blank?

    overlapping_bookings = Booking.where(boat_id: boat_id)
                                 .where.not(id: id)
                                 .where("(start_date, end_date) OVERLAPS (?, ?)", start_date, end_date)

    if overlapping_bookings.exists?
      errors.add(:end_date, " is already booked for the selected boat")
    end
  end
end
