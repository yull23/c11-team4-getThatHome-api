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
User.create(name: 'david', phone: '5520760605', email: 'david@example.com', password: 'password1', role: admin_role)
User.create(name: 'roxana', phone: '51986145530', email: 'roxana@example.com', password: 'password2', role: user_role)
User.create(name: 'yull1', phone: '51999999991', email: 'yull1@example.com', password: 'password', role: user_role)
User.create(name: 'yull2', phone: '51999999992', email: 'yull2@example.com', password: 'password', role: user_role)
User.create(name: 'yull3', phone: '51999999993', email: 'yull3@example.com', password: 'password', role: user_role)
User.create(name: 'yull4', phone: '51999999994', email: 'yull4@example.com', password: 'password', role: user_role)
User.create(name: 'yull5', phone: '51999999995', email: 'yull5@example.com', password: 'password', role: user_role)
User.create(name: 'yull6', phone: '51999999996', email: 'yull6@example.com', password: 'password', role: user_role)

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
end

# Properties
puts "start creating Properties"
urls = [
  "https://picsum.photos/id/1063/640",
  "https://picsum.photos/id/1061/640",
  "https://picsum.photos/id/1057/640",
  "https://picsum.photos/id/1056/640",
  "https://picsum.photos/id/1055/640",
  "https://picsum.photos/id/1054/640",
  "https://picsum.photos/id/1052/640",
  "https://picsum.photos/id/1051/640",
  "https://picsum.photos/id/1050/640",
  "https://picsum.photos/id/1049/640",
]

50.times do
  property_type = PropertyType.all.sample
  property_address = PropertyAddress.all.sample
  property = Property.create(
    property_type: property_type,
    property_address: property_address,
    bedrooms: rand(1...10),
    bathrooms: rand(1...5),
    area: rand(8..30) * 10,
    description: Faker::Lorem.paragraph_by_chars(number: 150, supplemental: false),
    photo_url: urls.sample,
    active: Faker::Boolean.boolean,
    price: Faker::Number.between(from: 1000, to: 5000),
    monthly_rent: Faker::Number.between(from: 500, to: 2000),
    maintenance: Faker::Number.between(from: 50, to: 500),
    pets_allowed: Faker::Boolean.boolean,
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

# Crear registros en la tabla user_properties

puts 'Start creating User Properties'




puts 'End creating User Properties'








# Crear registros en la tabla property_users
puts 'Start creating Property Users'
properties = Property.all
users= User.all[1..-1]

properties.each_with_index  do |property,index|
  if(index%3==3)
    PropertyUser.create(
      user: user,
      property: property,
      favorite: Faker::Boolean.boolean,
      contacted: Faker::Boolean.boolean
    )
  end
end
puts 'End creating Property Users'



