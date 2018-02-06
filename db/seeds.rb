# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create default admin
user = User.new(
    :username              => "admin",
    :role                  => :admin,
    :email                 => "admin@pm.com",
    :password              => "123456",
    :password_confirmation => "123456"
)
user.save!

# Create manager
user = User.new(
    :username              => "manager",
    :role                  => :manager,
    :email                 => "manager@pm.com",
    :password              => "123456",
    :password_confirmation => "123456"
)
user.save!

user = User.new(
    :username              => "user1",
    :role                  => :member,
    :email                 => "user1@pm.com",
    :password              => "123456",
    :password_confirmation => "123456"
)
user.save!

user = User.new(
    :username              => "user2",
    :role                  => :member,
    :email                 => "user2@pm.com",
    :password              => "123456",
    :password_confirmation => "123456"
)
user.save!


Tournament.create!(
    :name => "World Cup 2018",
    :location => "Russia",
    :year => 2018
)
