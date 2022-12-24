Event.delete_all
User.delete_all

# Create a default user
admin = User.create!(email: "admin@example.com", password: "password", admin: true)

# Create some additional users
10.times do |i|
    User.create!(email: "user#{i}@example.com", password: "password")
end
# Create some events
users = User.all
1.upto(10) do |i|
    Event.create!(title: "Event #{i}", description: "This is event #{i}", location: "Location #{i}", start_date: DateTime.now, end_date: DateTime.now + 1.day, user: users.sample)
end