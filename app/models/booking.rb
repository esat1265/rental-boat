class Booking < ApplicationRecord
  belongs_to :boat
  belongs_to :user

  after_save :calculate_amount

  private

  def calculate_amount
    return unless saved_change_to_end_date? && saved_change_to_start_date?

    total_amount = (end_date - start_date).to_i * boat.price_per_day
    self.update(total_amount: total_amount)
  end
end
