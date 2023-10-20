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
puts "Start Creating users"
User.create(name: 'user1', phone: '51999999991', email: 'user1@example.com', password: 'password', role: user_role)
User.create(name: 'user2', phone: '51999999992', email: 'user2@example.com', password: 'password', role: user_role)
User.create(name: 'user3', phone: '51999999993', email: 'user3@example.com', password: 'password', role: user_role)
User.create(name: 'user4', phone: '51999999994', email: 'user4@example.com', password: 'password', role: user_role)
User.create(name: 'user5', phone: '51999999995', email: 'user5@example.com', password: 'password', role: user_role)
User.create(name: 'user6', phone: '51999999996', email: 'user6@example.com', password: 'password', role: user_role)
User.create(name: 'admin1', phone: '51999999901', email: 'admin1@example.com', password: 'password', role: admin_role)
User.create(name: 'admin2', phone: '51999999902', email: 'admin2@example.com', password: 'password', role: admin_role)
User.create(name: 'admin3', phone: '51999999903', email: 'admin3@example.com', password: 'password', role: admin_role)
User.create(name: 'admin4', phone: '51999999904', email: 'admin4@example.com', password: 'password', role: admin_role)
User.create(name: 'admin5', phone: '51999999905', email: 'admin5@example.com', password: 'password', role: admin_role)
User.create(name: 'admin6', phone: '51999999906', email: 'admin6@example.com', password: 'password', role: admin_role)

users= User.all[0,6]
admins= User.all[6,12]

puts "End Creating users"

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
    user:admins.sample,
    operation: %w[Sale Rent].sample,
    price: Faker::Number.between(from: 1000, to: 5000),
    maintenance: Faker::Number.between(from: 50, to: 500),
    description: Faker::Lorem.paragraph_by_chars(number: 150, supplemental: false),
    area: rand(8..30) * 10,
    bedrooms: rand(1...10),
    bathrooms: rand(1...5),
    pets_allowed: Faker::Boolean.boolean,
    photo_url: urls.sample(2),
    active: Faker::Boolean.boolean,
  )
  unless property.persisted?
    puts property.errors.full_messages
    puts property
  end
end
puts "end creating properties"
properties = Property.all



# Crear registros en la tabla property_users
puts 'Start creating Property Users'

properties.each_with_index  do |property,index|
  if(index%3==0)
    PropertyUser.create(
      user: users.sample,
      property: property,
      favorite: Faker::Boolean.boolean,
      contacted: Faker::Boolean.boolean
    )
  end

end
puts 'End creating Property Users'



