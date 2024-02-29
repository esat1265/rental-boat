require "open-uri"
require "pexels"
require 'faker'

puts "Delete all datas"
Review.destroy_all
Booking.destroy_all
Boat.destroy_all
User.destroy_all


puts "Prepare data to create users"
first_names = ["John", "Emma", "Michael", "Sophia", "William", "Olivia", "James", "Ava", "Benjamin", "Isabella"]
last_names = ["Smith", "Johnson", "Williams", "Brown", "Jones", "Miller", "Davis", "Garcia", "Rodriguez", "Wilson"]


10.times do |i|
  puts "Create #{i+1} users"
  user = User.create!(
    email: Faker::Internet.email,
    password: 'password',
    first_name: first_names.sample,
    last_name: last_names.sample
  )
end

lat_long = [
  [ 43.2945804, 5.3692811 ],
  [ 17.93332959322654, -76.84377021319669 ],
  [ 53.5467278, 9.9690756 ],
  [ 33.4944184, 11.1152217 ],
  [ 36.128966, -5.4383629 ]
]

puts "Prepare data to create boats"
boat_names = [
  "Blue Marlin",
  "Sea Breeze",
  "Island Explorer",
  "Ocean Voyager",
  "Starlight Serenade",
  "Aqua Dream",
  "Silver Seagull",
  "Sunset Pearl",
  "Coastal Cruiser",
  "Emerald Tide",
  "Dolphin Dancer",
  "Sea Sapphire",
  "Marina Majesty",
  "Harbor Haven",
  "Azure Horizon",
  "Nautical Nova",
  "Coral Crest",
  "Wave Whisperer",
  "Neptune's Pride",
  "Seashell Symphony",
  "Maritime Melody",
  "Tranquil Tide",
  "Coastal Charm",
  "Sea Spirit",
  "Sailor's Delight",
  "Oceanic Odyssey",
  "Seafarer's Song",
  "Bluewater Bliss",
  "Sea Star",
  "Horizon Harmony"
]

boat_descriptions = [
  "Set sail on a journey of adventure and discovery aboard this magnificent vessel.",
  "Experience the tranquility of the open seas with breathtaking views and luxurious amenities.",
  "Escape to paradise on this elegant yacht, where every moment is a celebration of life.",
  "Embark on an unforgettable voyage filled with endless possibilities and boundless beauty.",
  "Indulge in the ultimate maritime experience aboard this sleek and stylish cruiser.",
  "Discover the magic of the ocean as you navigate its vast expanse in comfort and style.",
  "Relax and unwind in the lap of luxury as you cruise along pristine coastlines and sparkling waters.",
  "Savor the freedom of the open water and the serenity of nature on this exquisite boat.",
  "Create lasting memories with loved ones on this spacious and well-appointed vessel.",
  "Feel the thrill of adventure and the allure of the unknown on this captivating journey.",
  "Immerse yourself in the wonders of the sea and the beauty of the natural world.",
  "Experience the joy of sailing and the excitement of exploration on this remarkable yacht.",
  "Escape the ordinary and embrace the extraordinary on this unforgettable oceanic voyage.",
  "Bask in the glory of the sun and the soothing rhythm of the waves on this idyllic cruise.",
  "Discover hidden treasures and secret coves as you chart your own course to paradise.",
  "Celebrate life's special moments aboard this elegant and sophisticated vessel.",
  "Experience the thrill of adventure and the wonder of discovery on this epic sea expedition.",
  "Sail into the sunset and leave your worries behind on this dreamy nautical adventure.",
  "Feel the wind in your hair and the salt spray on your skin as you sail towards new horizons.",
  "Unleash your inner explorer and set course for adventure on this magnificent ocean voyage.",
  "Escape to a world of luxury and indulgence aboard this opulent and refined yacht.",
  "Experience the romance of the sea and the magic of the night sky on this enchanting cruise.",
  "Savor the peace and tranquility of the open water as you embark on a journey of discovery.",
  "Discover the beauty of the natural world and the majesty of the ocean on this extraordinary voyage.",
  "Experience the thrill of adventure and the serenity of nature on this unforgettable sailing trip.",
  "Sail away to paradise on this luxurious and spacious yacht, where every moment is pure bliss.",
  "Feel the freedom of the open sea and the excitement of exploration on this exhilarating voyage.",
  "Escape the hustle and bustle of everyday life and unwind in style on this luxurious cruise.",
  "Experience the magic of the ocean and the wonder of the natural world on this unforgettable journey.",
  "Embark on a voyage of discovery and adventure on this magnificent yacht, where every day is a new adventure."
]

50.times do |i|
  puts "Create #{i+1} boats"
  boat = Boat.create!(
    name: boat_names[i % boat_names.length],
    description: boat_descriptions[i % boat_descriptions.length],
    price_per_day: rand(500..5000),
    year_production: rand(1980..2023),
    user_id: User.pluck(:id).sample,
    latitude: lat_long[i % lat_long.length][0],
    longitude: lat_long[i % lat_long.length][1]
  )
end

boats_first = Boat.first(25)
boats_first.each_with_index do |boat, a|
  puts "#{a+1 } - Adding 1 images to Boat ##{boat.name}"
  file_path = Rails.root.join("app", "assets", "images", "bateau_#{a+1}.jpg")
  file = URI.open(file_path)
  boat.photos.attach(io: file, filename: "bateau_#{a+1}.jpg", content_type: "image/jpg")
  boat.save!
end

boats_last = Boat.last(5)
boats_last.each_with_index do |boat, a|
  puts "Adding 5 vimages to Boat ##{boat.name}"
  5.times do |b|
    puts "Image #{b+1} inserted"
    file_path = Rails.root.join("app", "assets", "images", "boat-#{a+1}-#{b+1}.jpg")
    file = URI.open(file_path)
    boat.photos.attach(io: file, filename: "boat-#{a+1}-#{b+1}.jpg", content_type: "image/jpg")
  end
  boat.save!
end

puts "Create 50 bookings"
50.times do |i|
  puts "Booking #{i+1} created"

  start_date = Faker::Date.between(from: Date.today, to: 1.year.from_now)
  end_date = start_date + rand(1..14).days
  total_amount = rand(100..1000)
  boat_id = Boat.pluck(:id).sample
  user_id = User.pluck(:id).sample
  comment = Faker::Lorem.sentence

  # Try to find a valid date range
  while Booking.where(boat_id: boat_id).where('(start_date <= ? AND end_date >= ?) OR (start_date <= ? AND end_date >= ?)', start_date, start_date, end_date, end_date).exists?
    start_date = Faker::Date.between(from: Date.today, to: 1.year.from_now)
    end_date = start_date + rand(1..14).days
  end

  Booking.create!(
    start_date: start_date,
    end_date: end_date,
    total_amount: total_amount,
    boat_id: boat_id,
    user_id: user_id,
    comment: comment
  )
end


puts "Prepare to add reviews"
fake_comments = [
  "Absolutely phenomenal experience! The boat rental made our vacation unforgettable.",
  "First-class service! The rental process was smooth, and the staff was incredibly helpful.",
  "Exhilarating adventure! Rented a speedboat and had a blast exploring the coastline.",
  "Great for bonding! Spent quality time with family and friends on the rented pontoon.",
  "A day well spent! The boat rental allowed us to relax and recharge surrounded by nature.",
  "Impressed by the attention to safety! The rental company provided thorough instructions.",
  "Thrilling water sports! Rented jet skis and had an adrenaline-filled day on the lake.",
  "Unforgettable anniversary celebration! Thanks to the boat rental for making it special.",
  "Spectacular sunrise views! Highly recommend the early morning boat rental.",
  "Top-notch equipment! The boat was in excellent condition, exceeding our expectations.",
  "Great communication! The rental company kept us informed every step of the way.",
  "Peaceful retreat! The boat rental allowed us to escape the hustle and bustle.",
  "Professional and courteous staff! Made us feel welcome from the moment we arrived.",
  "A dream come true! Always wanted to sail, and the boat rental made it possible.",
  "Great for exploring! Rented a kayak and had a fantastic time exploring the coastline.",
  "Fantastic team! The rental staff went above and beyond to ensure our satisfaction.",
  "Stress-free experience! Booking online was easy, and pickup was a breeze.",
  "Highly recommend the sunset cruise! A magical experience we'll never forget.",
  "Fantastic amenities! The boat was equipped with everything we needed for a perfect day.",
  "Great for wildlife spotting! Saw dolphins and seabirds while out on the water.",
  "Unbeatable value! Affordable rates for an unforgettable experience.",
  "Smooth sailing! The boat handled beautifully, even in choppy waters.",
  "Excellent customer service! The rental staff were friendly and accommodating.",
  "Perfect for a romantic outing! Enjoyed a sunset cruise with my partner.",
  "Family-friendly fun! The kids had a blast swimming and exploring from the boat.",
  "Incredible scenery! The boat rental allowed us to see the area from a new perspective.",
  "Seamless process! From reservation to return, everything was effortless.",
  "Highly impressed! The rental company exceeded our expectations in every way.",
  "Relaxing getaway! The boat rental provided the perfect escape from everyday stress.",
  "Absolutely breathtaking! The sunset views from the boat were out of this world.",
  "Great for special occasions! Celebrated a milestone birthday with a boat rental.",
  "Safe and enjoyable! The rental company prioritized our safety at every turn.",
  "Fantastic fishing trip! Caught plenty of fish thanks to the well-equipped boat.",
  "Superb experience! Rented a sailboat and had an amazing day on the water.",
  "Attention to detail! The rental company thought of everything to ensure our comfort.",
  "Highly recommend the snorkeling tour! Saw incredible marine life thanks to the boat rental.",
  "Stunning coastline! The boat rental allowed us to explore hidden coves and beaches.",
  "Fantastic sunset cruise! The views were absolutely stunning.",
  "Great for nature lovers! Saw seals and seabirds while out on the water.",
  "Efficient operation! Got us on the water quickly so we could maximize our time.",
  "Perfect for a group outing! Rented a pontoon and had a blast with friends.",
  "Unforgettable experience! The boat rental was the highlight of our vacation.",
  "Excellent condition! The boat was clean and well-maintained.",
  "Smooth sailing! The rental process was hassle-free from start to finish.",
  "Highly recommend the guided tour! Learned so much about the area thanks to the boat rental.",
  "Family-friendly fun! The kids had a blast swimming and exploring from the boat.",
  "Reliable service! The rental company was professional and trustworthy.",
  "Absolutely breathtaking! The sunset views from the boat were unforgettable.",
  "Convenient location! The rental dock was easy to find with ample parking.",
  "An adventure to remember! The boat rental provided memories that will last a lifetime."

puts "Generate 50 fakes reviews with rating"
50.times do |i|
  puts "Review #{i+1} created"
  Review.create!(
    rating: rand(3..5),
    comment: fake_comments[i],
    user_id: User.pluck(:id).sample,
    booking_id: Booking.pluck(:id).sample
  )
end