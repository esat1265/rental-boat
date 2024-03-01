class Boat < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many_attached :photos
  validates :price_per_day, numericality: { greater_than: 1, message: "must be more than 0" }
  validates :year_production, numericality: { less_than_or_equal_to: 2024, message: "must be 2024 or earlier" }

  def self.available(start_date, end_date, boat_name = nil)
    query = left_joins(:bookings)
      .where('bookings.id IS NULL OR (bookings.start_date > ? OR bookings.end_date < ?)', end_date, start_date)
      .distinct
    query = query.where("name ILIKE ?", "%#{boat_name}%") if boat_name.present?

    query
  end
end
