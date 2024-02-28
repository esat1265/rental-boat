require "open-uri"

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Booking.destroy_all
Boat.destroy_all
User.destroy_all

# Array of dummy user data
dummy_users = [
  { email: 'john@example.com', password: 'password', first_name: 'John', last_name: 'Doe' },
  { email: 'jane@example.com', password: 'password', first_name: 'Jane', last_name: 'Doe' },
  # Add more dummy user data as needed
]

# Create users from dummy data
dummy_users.each do |user_data|
  User.create!(user_data)
end

# Define an array of sample boat names
boat_names = [
  "Sea Breeze",
  "Ocean Voyager",
  "Sailor's Delight",
  "Wave Rider",
  "Marine Explorer",
  "Aqua Dream",
  "Island Hopper",
  "Captain's Choice",
  "Sunset Cruiser",
  "Blue Horizon"
]

# Define an array of sample boat descriptions
boat_descriptions = [
  "Experience the ultimate luxury on the high seas.",
  "Perfect for a day of fishing or leisurely cruising.",
  "Sail in style with this sleek and modern vessel.",
  "Built for adventure and ready to explore any coastline.",
  "Enjoy breathtaking views and exceptional comfort aboard this boat.",
  "Escape the ordinary and set sail on your next adventure.",
  "Discover new destinations and create unforgettable memories.",
  "Luxury meets performance in this meticulously crafted boat.",
  "Relax and unwind as you glide across the water in style.",
  "Experience the thrill of the open ocean with this exceptional boat."
]

# Define the range for price_per_day and year_production
price_range = (50..500)
year_range = (2000..2024)

# Create 10 boat records

10.times do |i|
  boat = Boat.new(
    name: boat_names.sample,
    description: boat_descriptions.sample,
    price_per_day: rand(price_range),
    year_production: rand(year_range),
    user: User.all.sample
  )
  3.times do |j|
    file = URI.open("https://picsum.photos/374/250")
    boat.photos.attach(io: file, filename: "boat-image.jpg", content_type: "image/jpg")
  end
  boat.save!
end
