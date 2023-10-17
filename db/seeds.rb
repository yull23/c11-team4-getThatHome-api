require "faker"

puts "start destroying data ..."
Property.destroy_all
User.destroy_all
Role.destroy_all
puts "end destroying data ..."

Role.create(name: 'HomeSeeker')
Role.create(name: 'Landlord')

puts "End creating roles"
# Primero, obtén las instancias de los roles
admin_role = Role.find_by(name: 'Landlord')
user_role = Role.find_by(name: 'HomeSeeker')


# Crea usuarios con roles
puts "Creating users"
User.create(name: 'david', email: 'david@example.com', password: 'password1', role: admin_role)
User.create(name: 'roxana', email: 'roxana@example.com', password: 'password2', role: user_role)


puts "start creating property types"
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

# Crear registros ficticios en la tabla property_addresses
10.times do
  property_address = PropertyAddress.create(
    name: Faker::Address.street_name,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude
  )

# Properties
puts "start creating Properties"
urls = ["https://images.freeimages.com/images/large-previews/e85/house-1224030.jpg",
        "https://media.istockphoto.com/photos/new-housing-estate-with-underground-garage-picture-id1287012612?s=612x612", "https://images.freeimages.com/images/large-previews/d5b/home-1224274.jpg", "https://images.freeimages.com/images/large-previews/4b4/beach-house-1225387.jpg"]

20.times do
  property_type = PropertyType.all.sample
  property = Property.create(
    property_type: property_type,
    property_address: property_address,
    bedrooms: rand(1...10),
    bathrooms: rand(1...5),
    area: rand(8..30) * 10,
    description: Faker::Lorem.paragraph_by_chars(number: 150, supplemental: false),
    photo_url: urls.sample(rand(1...urls.length)),
    active: Faker::Boolean.boolean,
    price: Faker::Number.between(from: 1000, to: 5000),
    monthly_rent: Faker::Number.between(from: 500, to: 2000),
    maintenance: Faker::Number.between(from: 50, to: 500),
    pets_allowed: Faker::Boolean.boolean,
    operation: "For sale"
  )
  unless property.persisted?
    puts property.errors.full_messages
    puts property
  end
end
puts "end creating properties"

end