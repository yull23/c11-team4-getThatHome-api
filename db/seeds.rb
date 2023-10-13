# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "faker"

Role.create(name: 'admin')
Role.create(name: 'Landlord')
Role.create(name: 'editor')
puts "End creating roles"
# Primero, obtén las instancias de los roles
admin_role = Role.find_by(name: 'admin')
user_role = Role.find_by(name: 'Landlord')
editor_role = Role.find_by(name: 'editor')

# Crea usuarios con roles
<<<<<<< HEAD
puts "Creating users with roles"
=======
puts "Creating users"
>>>>>>> issue#4-create-device
User.create(name: 'david', email: 'david@example.com', password: 'password1', password_confirmation: 'password1', role: admin_role)
User.create(name: 'roxana', email: 'roxana@example.com', password: '  ', password_confirmation: 'password2', role: user_role)
User.create(name: 'yull', email: 'yull@example.com', password: 'password3', password_confirmation: 'password3', role: editor_role)

# Property Types
puts "Creating property types"
types = [
  {
    name: "Apartment"
  }, {
    name: "House"
  }
]

types.each do |type_data|
  type = PropertyType.create(type_data)
  unless type.persisted?
    puts type.errors.full_messages
    puts type
  end
end
puts "end creating property types"
<<<<<<< HEAD
=======

# Addresses
puts "start creating addresses"
addresses_data = JSON.parse(File.read("db/addresses.json"), symbolize_names: true)
addresses_data.each do |address_data|
  address = PropertyAddress.create(address_data)
  unless address.persisted?
    puts address.errors.full_messages
    puts address
  end
end
puts "end creating addresses"

# Properties
puts "start creating properties"
urls = ["https://images.freeimages.com/images/large-previews/e85/house-1224030.jpg",
        "https://media.istockphoto.com/photos/new-housing-estate-with-underground-garage-picture-id1287012612?s=612x612", "https://images.freeimages.com/images/large-previews/d5b/home-1224274.jpg", "https://images.freeimages.com/images/large-previews/4b4/beach-house-1225387.jpg"]

addresses = PropertyAddress.all.to_a
types = PropertyType.all.to_a
20.times do
  property = Property.create(
    property_address: addresses.sample,
    property_type: types.sample,
    bedrooms: rand(1...10),
    bathrooms: rand(1...5),
    area: rand(8..30) * 10,
    description: Faker::Lorem.paragraph_by_chars(number: 150, supplemental: false),
    photo_url: urls.sample(rand(2...urls.length)),
    active:true
  )
  unless property.persisted?
    puts property.errors.full_messages
    puts property
  end
end
puts "end creating properties"

# Properties For Rent or Sale
puts "start creating properties for sale or rent"
properties = Property.all.to_a
rent_group_length = rand(1...properties.length)
rent_group = properties.sample(rent_group_length)
sale_group = properties - rent_group

rent_group.each do |property|
  rent = PropertyForRent.create(
    property:,
    monthly_rent: rand(8...30) * 100,
    maintenance: rand(1...12) * 20,
    pets_allowed: [true, false].sample
  )
  unless rent.persisted?
    puts rent.errors.full_messages
    puts rent
  end
end

sale_group.each do |property|
  sale = PropertyForSale.create(
    property:,
    price: rand(8...30) * 100
  )
  unless sale.persisted?
    puts sale.errors.full_messages
    puts sale
  end
end
puts "end creating properties for sale or rent"

puts "start creating own"
landlords = User.where(role: Role.find_by(name: "Landlord")).to_a
properties_to_own = PropertyForSale.all.to_a + PropertyForRent.all.to_a

properties_to_own.each do |property|
  ownable_property = UserProperty.create(
    userPropertyable: property,
    user: landlords.sample
  )

  unless ownable_property.persisted?
    puts ownable_property.errors.full_messages
    puts ownable_property
  end
end
puts "end creating own"
>>>>>>> issue#4-create-device
