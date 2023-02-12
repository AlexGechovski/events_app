require 'faker'

sample_images = [  "sample1.jpg",  "sample2.jpg",  "sample3.jpg"]

# Create Users
15.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "password"
  )
end

users = User.all
# Create Events
10.times do
  event = Event.create!(
    title: Faker::Book.title,
    description: Faker::Lorem.paragraph,
    location: Faker::Address.street_address,
    start_date: DateTime.now,
    end_date: DateTime.now + 1.day,
    user: users.sample,
  )
  image_path = File.join(Rails.root, "app/assets/images/#{sample_images.sample}")
  event.image.attach(io: File.open(image_path), filename: "sample_image.jpg")
end

# Create Attendances
20.times do
  Attendance.create!(
    user_id: User.all.sample.id,
    event_id: Event.all.sample.id
  )
end

# Create Comments
50.times do
  Comment.create!(
    text: Faker::Lorem.sentence,
    user_id: User.all.sample.id,
    event_id: Event.all.sample.id
  )
end

10.times do |i|
  User.create!(email: "user#{i}@example.com", password: "password", name: "Ivan Ivanov")
end

puts "Seed finished"