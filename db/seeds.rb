# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Faker::Config.locale = 'en-GB'

# Create default fake admin user
admin = User.create(
  email:          'admin@exmaple.com',
  name:           Faker::Name.name,
  date_of_birth:  Faker::Date.between(40.years.ago, 20.years.ago),
  phone_number:   Faker::PhoneNumber.cell_phone,
  password:              '12341234',
  password_confirmation: '12341234'
)

# Create second non-admin user
user = User.create(
  email:          'user@example.com',
  name:           Faker::Name.name,
  date_of_birth:  Faker::Date.between(40.years.ago, 20.years.ago),
  phone_number:   Faker::PhoneNumber.cell_phone,
  password:              '12341234',
  password_confirmation: '12341234'
)

# Create basic types of spaces:
['Hot Desk', 'Fixed Desk', 'Meeting Room', 'Event Space'].each do |name|
  SpaceType.create(name: name)
end

# Amenities (features)
['Wi-fi', 'Meeting room', 'Furniture', 'Lockers', 'Showers', '24h access',
 'Kitchen', 'Bike storage', 'Event space', 'Mailing address',
 'Disabled access'].each do |amenity|
   Amenity.create(
     name: amenity
   )
 end

# Create a space for admin user
10.times do
  Space.create(
    user: admin,
    space_type: SpaceType.order('RANDOM()').first,
    title: Faker::Book.title,
    slug:  Faker::Internet.slug,
    description: Faker::Lorem.paragraph,
    address_line_1: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    country: Faker::Address.country,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    amenities: Amenity.order('RANDOM()').limit(5)
  )
end

10.times do
  Space.create(
    user: user,
    space_type: SpaceType.order('RANDOM()').first,
    title: Faker::Book.title,
    slug:  Faker::Internet.slug,
    description: Faker::Internet.slug,
    address_line_1: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    country: Faker::Address.country,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    amenities: Amenity.order('RANDOM()').limit(5)
  )
end
