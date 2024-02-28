class Boat < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many_attached :photos

  def self.available(start_date, end_date)
    left_joins(:bookings)
      .where('bookings.id IS NULL OR (bookings.start_date > ? OR bookings.end_date < ?)', end_date, start_date)
      .distinct
  end
end
