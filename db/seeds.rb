# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create default admin
user = User.new(
    :username              => "alex",
    :role                  => :admin,
    :email                 => "alex@pari-magique.com",
    :password              => "123456",
    :password_confirmation => "123456"
)
user.save!

Team.create!(
    :name => "France",
    :code => "FRA",
    :flag => "fra.gif",
    :selection => 0
)

Team.create!(
    :name => "Pologne",
    :code => "POL",
    :flag => "pol.gif",
    :selection => 0
)

Team.create!(
    :name => "Grèce",
    :code => "GRC",
    :flag => "grc.gif",
    :selection => 0
)

Team.create!(
    :name => "Russie",
    :code => "RUS",
    :flag => "rus.gif",
    :selection => 0
)

Stadium.create!(
    :name => "Stade de France",
    :city => "Paris",
    :capacity => 80000
)

Tournament.create!(
    :name => "World Cup 2018",
    :location => "Russie",
    :year => 2018
)