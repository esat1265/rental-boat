require "open-uri"
require "pexels"

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

client = Pexels::Client.new(ENV['PEXELS_API_KEY'])

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


# Define the range for price_per_day and year_production
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
  "Blue Horizon",
  "Horizon Seeker",
  "Mystic Seafarer",
  "Nautical Nomad",
  "Deep Sea Diver",
  "Coral Quest",
  "Maritime Mirage",
  "Wanderlust Waves",
  "Seaside Serenity",
  "Ocean Odyssey",
  "Tide Traveler",
]

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
    "Experience the thrill of the open ocean with this exceptional boat.",
    "Designed for the passionate angler and the adventurous sailor.",
    "A masterpiece of engineering for those who demand excellence.",
    "Embark on a journey of discovery with unparalleled elegance.",
    "A sanctuary on the sea, blending sophistication with tranquility.",
    "Navigate the waters with ease and grace in this dynamic craft.",
    "For the thrill-seekers and the sun worshippers, an unmatched experience.",
    "Innovative design meets unmatched comfort in this maritime marvel.",
    "Capture the essence of the sea in this ultimate family getaway.",
    "The adventurer's choice for exploring untamed waters.",
    "Where luxury and adventure go hand in hand, your dream vessel awaits."
]


keywords = [
  "boats",
  "yachts",
  "white boat",
  "yacht",
  "yachtss",
  "sailing boat",
]

price_range = (150..300)
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

  # Use a different keyword for each search
  keyword = keywords.sample

  client.photos.search(keyword, per_page: 3).each_with_index do |photo, index|
    next unless photo.src&.has_key?('original')

    file = URI.open(photo.src['original'])
    boat.photos.attach(io: file, filename: "boat-#{i}-image-#{index}.jpg", content_type: "image/jpg")
  end

  boat.save!
end
