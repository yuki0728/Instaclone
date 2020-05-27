# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(
  name:  "foo bar",
  user_name: "foo bar",
  email: "example@mail.com",
  password:              "foobar",
  password_confirmation: "foobar",
  activated: true,
  activate_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = Faker::Internet.email
  user_name = Faker::Internet.user_name
  password = "password"
  User.create!(
    name:  name,
    user_name: user_name,
    email: email,
    password:              password,
    password_confirmation: password,
    activated: true,
    activate_at: Time.zone.now
  )
end

users = User.order(:created_at).take(6)
50.times do
  text = Faker::Lorem.sentence(5)
  users.each { |user| user.posts.create!(text: text) }
end

# リレーションシップ
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
