class Boat < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many_attached :photos

  def self.available(start_date, end_date, boat_name = nil)
    query = left_joins(:bookings)
      .where('bookings.id IS NULL OR (bookings.start_date > ? OR bookings.end_date < ?)', end_date, start_date)
      .distinct
    query = query.where("name ILIKE ?", "%#{boat_name}%") if boat_name.present?

    query
  end
end
