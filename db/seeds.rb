require "open-uri"
require "pexels"
require 'faker'

boats = Boat.all

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

boat_details = [
  "Step aboard our exquisite rental boat and embark on a journey of unparalleled luxury and adventure. Crafted with precision and elegance, our boat offers the perfect blend of style and functionality, ensuring a memorable experience on the water. Set sail with confidence as you navigate pristine coastlines, tranquil bays, and hidden coves, discovering breathtaking vistas and natural wonders along the way. <br><br>

  Designed for discerning travelers seeking the ultimate aquatic escape, our rental boat boasts spacious interiors, plush seating, and top-of-the-line amenities, providing unparalleled comfort and convenience. Whether you're planning a romantic sunset cruise, a family day out, or an adrenaline-fueled water sports adventure, our versatile boat is equipped to exceed your expectations. <br><br>

  Indulge in the freedom to explore at your own pace, charting a course to secluded beaches, vibrant coral reefs, and picturesque fishing spots. Dive into crystal-clear waters for a refreshing swim, snorkel amongst colorful marine life, or simply bask in the sun on the expansive deck, savoring moments of tranquility and serenity. <br><br>

  With our experienced crew at your service, you can relax and unwind as we take care of every detail, from navigation to onboard dining. Treat yourself to gourmet meals prepared fresh onboard, paired with fine wines and champagne, for a truly indulgent experience. <br><br>

  Whether you're celebrating a special occasion, bonding with loved ones, or simply seeking refuge from the hustle and bustle of daily life, our rental boat offers the perfect sanctuary on the water. Come aboard and experience the magic of the sea, where every moment is a treasure to be cherished forever.",

  "Step aboard our sleek and modern rental boat and prepare to embark on an adventure like no other. With its cutting-edge design and state-of-the-art features, our boat offers an unparalleled experience on the water. <br><br>

  Cruise along the shimmering waves and explore hidden coves, secluded beaches, and vibrant coral reefs. Our boat is equipped for all types of excursions, whether you're seeking a thrilling water sports adventure or a tranquil sunset cruise. <br><br>

  Feel the wind in your hair as you navigate the open sea, or anchor in a serene bay and dive into the crystal-clear waters for a refreshing swim. Snorkel amongst colorful marine life, or simply relax on the spacious deck and soak up the sun. <br><br>

  With comfortable seating, modern amenities, and plenty of space to stretch out and relax, our boat is the perfect setting for any occasion. Whether you're celebrating a special milestone, bonding with loved ones, or simply escaping the hustle and bustle of everyday life, our rental boat provides the ideal retreat. <br><br>

  Our experienced crew is dedicated to ensuring your safety and enjoyment throughout your journey. From navigation to on-board entertainment, we take care of every detail so you can focus on making memories that will last a lifetime.

Come aboard and experience the freedom and excitement of the open water with us. Your adventure awaits!"
]

25.times do |i|
  puts "Create #{i+1} boats"
  boat = Boat.create!(
    name: boat_names[i % boat_names.length],
    description: boat_descriptions[i % boat_descriptions.length],
    price_per_day: rand(500..5000),
    year_production: rand(1980..2023),
    user_id: User.pluck(:id).sample,
    latitude: lat_long[i % lat_long.length][0],
    longitude: lat_long[i % lat_long.length][1],
    details: boat_details.sample
  )
end

all_boats = Boat.all

all_boats.each do |boat|
  puts "Add details to boat"
  boat.details = boat_details.sample
  boat.save!
end

boats_first = Boat.last(20)
boats_first.each_with_index do |boat, a|
  puts "#{a+1 } - Adding 1 images to Boat ##{boat.name}"
  file_path = Rails.root.join("app", "assets", "images", "bateau_#{a+1}.jpg")
  file = URI.open(file_path)
  boat.photos.attach(io: file, filename: "bateau_#{a+1}.jpg", content_type: "image/jpg")
  boat.save!
end

boats_last = Boat.first(5)
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

puts "Create 3 bookings per boat"
all_boats.each do |boat|
  2.times do |i|
    start_date = Faker::Date.between(from: Date.today, to: 1.year.from_now)
    end_date = start_date + rand(1..14).days
    total_amount = rand(100..1000)
    boat_id = boat.id
    user_id = User.pluck(:id).sample
    comment = Faker::Lorem.sentence

    # Tryin to find a valid date range
    while boat.bookings.where('(start_date <= ? AND end_date >= ?) OR (start_date <= ? AND end_date >= ?)', start_date, start_date, end_date, end_date).exists?
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
    puts "Booking #{i+1} created"
  end
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
  "An adventure to remember! The boat rental provided memories that will last a lifetime.",
  "Effortless experience! The rental process was quick and efficient, allowing us to hit the water in no time. Perfect for making the most out of our day on the lake.",
  "Great for a family day out! We rented a spacious pontoon and had a fantastic time cruising around with the kids. Plenty of room for everyone to relax and enjoy the sunshine.",
  "Highlight of our vacation! Renting a boat was the best decision we made during our trip. From exploring hidden coves to spotting dolphins, it was an unforgettable adventure.",
  "Impeccable condition! The boat we rented was spotless and well-maintained, giving us peace of mind throughout our excursion.",
  "Seamless experience! From booking online to returning the boat, everything went smoothly. Made for a stress-free day on the water.",
  "Guided tour was a game-changer! Our knowledgeable guide enhanced the experience, providing fascinating insights about the local history and wildlife.",
  "Fun for the whole family! The kids had a blast swimming off the boat and searching for seashells along the shore.",
  "Dependable service! The rental company was reliable and professional, ensuring a worry-free experience from start to finish.",
  "Spectacular sunset views! Watching the sun dip below the horizon from the deck of the boat was truly magical. A must-do for anyone visiting the area.",
  "Conveniently located! The rental dock was easy to find, with plenty of parking available nearby. Made it a breeze to start our aquatic adventure.",
  "Efficient and friendly service! The staff helped us get acquainted with the boat and provided useful tips for navigating the waterways.",
  "Picture-perfect day! Renting a boat allowed us to explore hidden gems and capture stunning photos along the coastline.",
  "Top-notch experience! The boat exceeded our expectations in terms of comfort and performance, making for a memorable day on the water.",
  "Smooth sailing all the way! From reservation to return, the rental process was seamless and hassle-free.",
  "Informative and entertaining tour! Renting a boat with a guide added an extra layer of enjoyment as we learned fascinating facts about the area.",
  "Fun-filled adventure! Renting a boat provided endless opportunities for snorkeling, swimming, and soaking up the sun.",
  "Trustworthy rental company! We felt confident in the equipment and service provided, allowing us to relax and enjoy our time on the water.",
  "Unbeatable views! Renting a boat allowed us to explore remote islands and admire the breathtaking scenery from a unique perspective.",
  "Family bonding at its finest! Renting a boat gave us the chance to disconnect from screens and reconnect with each other amidst nature's beauty.",
  "Five-star experience! The convenience, affordability, and sheer enjoyment of renting a boat made it the highlight of our vacation.",
  "Prompt and professional! The rental process was streamlined, and we were out on the water in no time. Perfect for maximizing our leisure time.",
  "Ideal for group outings! We rented a spacious pontoon and had an absolute blast with friends and family. Plenty of room for everyone to relax and enjoy.",
  "Unforgettable memories! Renting a boat added an extra layer of excitement to our vacation, creating memories that will last a lifetime.",
  "Spotless condition! The boat we rented was impeccably clean and well-maintained, ensuring a comfortable and enjoyable experience.",
  "Effortless journey! From booking to return, the rental process was smooth sailing, allowing us to focus on enjoying our time on the water.",
  "Insightful guided tour! Renting a boat with a knowledgeable guide provided a deeper understanding of the local area and its natural wonders.",
  "Kid-friendly fun! Renting a boat kept the little ones entertained for hours, with endless opportunities for swimming and exploring.",
  "Reliable service! The rental company's professionalism and attention to detail gave us peace of mind throughout our excursion.",
  "Breathtaking sunset views! Renting a boat allowed us to witness the beauty of the setting sun from a whole new perspective.",
  "Conveniently located! The rental dock was easy to find, making it a breeze to kick off our aquatic adventure.",
  "Efficient operation! The rental staff got us on the water quickly, ensuring we could make the most of our rental time.",
  "Perfect for group getaways! Renting a boat provided the ideal setting for bonding with friends and creating unforgettable memories.",
  "Immaculate condition! The boat we rented was in top-notch shape, making for a comfortable and enjoyable experience.",
  "Seamless journey! Renting a boat was hassle-free from start to finish, allowing us to focus on enjoying the beauty of our surroundings.",
  "Informative guided tour! Renting a boat with a knowledgeable guide added an extra layer of enjoyment as we explored the area.",
  "Family-friendly adventure! Renting a boat kept the whole family entertained, with endless opportunities for fun and relaxation.",
  "Dependable service! The rental company's professionalism and reliability made for a stress-free experience.",
  "Unforgettable experience! Renting a boat allowed us to create memories that will last a lifetime.",
  "Stunning sunset cruise! Renting a boat provided the perfect setting for admiring the beauty of the setting sun.",
  "Convenient location! The rental dock was easy to access, making it simple to start our aquatic adventure.",
  "Efficient service! Renting a boat was quick and easy, allowing us to spend more time enjoying the water.",
  "Great for group outings! We rented a spacious boat and had a fantastic time with friends. Plenty of room for everyone to relax and have fun.",
  "Memorable experience! Renting a boat added excitement and adventure to our vacation, creating memories that we'll cherish forever.",
  "Well-maintained equipment! The boat we rented was clean and in excellent condition, ensuring a safe and enjoyable ride.",
  "Smooth process! Renting a boat was hassle-free, from making the reservation to returning the boat at the end of the day.",
  "Informative tour! Renting a boat with a guide gave us a deeper understanding of the area's history and natural beauty.",
  "Family-friendly fun! Renting a boat kept the kids entertained with swimming, exploring, and soaking up the sun.",
  "Trustworthy rental company! We felt confident in the reliability and professionalism of the rental service.",
  "Breathtaking views! Renting a boat allowed us to see the area from a new perspective and admire its beauty.",
  "Convenient location! The rental dock was easy to find, making it simple to start our boating adventure.",
  "Smooth operation! The rental staff were efficient and helpful, ensuring a seamless experience from start to finish.",
  "Perfect for celebrations! Renting a boat made for a memorable birthday party with friends and family.",
  "Spotless condition! The boat we rented was immaculately clean, adding to the overall enjoyment of our experience.",
  "Effortless journey! Renting a boat was stress-free and straightforward, allowing us to focus on having fun.",
  "Engaging tour! Renting a boat with a knowledgeable guide provided valuable insights and enhanced our enjoyment of the experience.",
  "Family-friendly adventure! Renting a boat kept everyone entertained with activities like fishing, swimming, and sightseeing.",
  "Dependable service! The rental company's professionalism and attention to detail made for a worry-free experience.",
  "Unforgettable memories! Renting a boat allowed us to create lasting memories with loved ones.",
  "Spectacular sunset cruise! Renting a boat provided the perfect setting for enjoying the beauty of the sunset.",
  "Accessible location! The rental dock was conveniently located, making it easy to start our boating adventure."
]



boats.each do |boat|
  booking = boat.bookings.sample
  10.times do |i|
    puts "Generate #{i+1} fake review for boat #{boat.name}"

    Review.create!(
      rating: rand(2..5),
      comment: fake_comments.sample,
      user_id: User.pluck(:id).sample,
      booking_id: booking.id
    )
  end
end
