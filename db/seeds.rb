require "faker"

puts "start destroying data ..."
Role.destroy_all
User.destroy_all
PropertyType.destroy_all
Property.destroy_all
PropertyAddress.destroy_all
PropertyUser.destroy_all 
puts "end destroying data ..."

Role.create(name: 'Landord')
Role.create(name: 'HomeSeeker')

puts "End creating roles"
# Primero, obtén las instancias de los roles
admin_role = Role.find_by(name: 'Landord')
user_role = Role.find_by(name: 'HomeSeeker')

# Crea usuarios con roles
puts "Creating users"
User.create(name: 'david',phone: '5520760605',email: 'david@example.com', password: 'password1', role: admin_role)
User.create(name: 'roxana',phone: '51986145530', email: 'roxana@example.com', password: 'password2', role: user_role)


puts "Start creating property types"
property_types = ["Apartment", "House"]

property_types.each do |type|
  PropertyType.create(name: type)
end
puts "End creating property types"

# Crear registros ficticios en la tabla property_addresses
puts 'Start creating Property Addresses'
10.times do
  property_address = PropertyAddress.create(
    name: Faker::Address.street_name,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude
  )

  puts 'End creating Property Addresses'

  # Crear registros en la tabla property_users
  puts 'Start creating Property Users'
  users = User.all
  properties = Property.all

  users.each do |user|
  properties.sample(5).each do |property|
    PropertyUser.create(
      user: user,
      property: property,
      favorite: Faker::Boolean.boolean,
      contacted: Faker::Boolean.boolean
    )
  end
end
puts 'End creating Property Users'

# Properties
puts "start creating Properties"
urls = ["https://images.freeimages.com/images/large-previews/e85/house-1224030.jpg",
        "https://media.istockphoto.com/photos/new-housing-estate-with-underground-garage-picture-id1287012612?s=612x612", "https://images.freeimages.com/images/large-previews/d5b/home-1224274.jpg", "https://images.freeimages.com/images/large-previews/4b4/beach-house-1225387.jpg"]

  10.times do
    property_type = PropertyType.all.sample
    property = Property.create(
      property_type: property_type,
      property_address: property_address,
      bedrooms: rand(1...10),
      bathrooms: rand(1...5),
      area: rand(8..30) * 10,
      description: Faker::Lorem.paragraph_by_chars(number: 150, supplemental: false),
      photo_url: urls.sample(rand(2...urls.length)),
      active: Faker::Boolean.boolean,
      operation: %w[Sale Rent].sample,
      t_phone: Faker::PhoneNumber.cell_phone,
      t_email: Faker::Internet.email
    )
    unless property.persisted?
      puts property.errors.full_messages
      puts property
    end
  end
  puts "end creating properties"

end
puts "end creating properties"

puts "Create PropertyUsers"
property = Property.all.to_a
user = User.all.to_a
20.times do
  propertyUser = PropertyUser.create(
    property_id: property.sample,
    user_id: user.sample,
    favorite:true,
    contacted:true
  )
  unless propertyUser .persisted?
    puts propertyUser .errors.full_messages
    puts propertyUser 
  end
end
puts "End PropertyUsers"

# Crear propiedades en venta y alquiler
puts "Start creating properties for sale or rent"
properties = Property.all
rent_group = properties.sample(rand(1..properties.length))
sale_group = properties - rent_group

rent_group.each do |property|
  PropertyForRent.create(
    property: property,
    monthly_rent: rand(8..30) * 100,
    maintenance: rand(1..12) * 20,
    pets_allowed: [true, false].sample
  )
end

sale_group.each do |property|
  PropertyForSale.create(
    property: property,
    price: rand(8..30) * 100
  )
end
puts "End creating properties for sale or rent"
