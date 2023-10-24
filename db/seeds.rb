puts "start destroying data ..."
Role.destroy_all
User.destroy_all
PropertyType.destroy_all
Property.destroy_all
PropertyAddress.destroy_all
PropertyUser.destroy_all 
puts "end destroying data ..."

Role.create(name: 'LandLord')
Role.create(name: 'HomeSeeker')

puts "End creating roles"
# Primero, obtén las instancias de los roles
admin_role = Role.find_by(name: 'LandLord')
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

data = [
  {
    "name" => "28 Fuji-kaido Avenue, Nerima",
    "latitude" => 35.7387174,
    "longitude" => 139.530138
  },
  {
    "name" => "1357 Fifth Avenue",
    "latitude" => 40.7987658,
    "longitude" => -73.9500646
  },
  {
    "name" => "53470 Parque Industrial Naucalpan",
    "latitude" => 19.469216,
    "longitude" => -99.2440401
  },
  {
    "name" => "12 Spence Ln, New Nagpada",
    "latitude" => 18.9681846,
    "longitude" => 72.8317289
  },
  {
    "name" => "1041 Guilherme Giorgi Avenue, Vila Carrao",
    "latitude" => -23.5553799,
    "longitude" => -46.5474426
  },
  {
    "name" => "456 Amador Merino Reyna Street, San Isidro",
    "latitude" => -12.0927445,
    "longitude" => -77.0312976
  },
  {
    "name" => "Hipódromo",
    "latitude" => 19.40611391061782,
    "longitude" =>  -99.17696487743181
  },
  {
    "name" => "Jardin del Agua",
    "latitude" => 19.413617487884636,
    "longitude" => -99.19630478719317
  },
  {
    "name" => "Historia Natural y Cultura Ambiental",
    "latitude" => 19.410075857482394,
    "longitude" => -99.20154045884821
  },
  {
    "name" => "Casa de la Bola",
    "latitude" => 19.40521728795997,
    "longitude" => -99.18826406767128
  },
  {
    "name" => "Bellas Artes",
    "latitude" => 19.435928780348842,
    "longitude" => -99.1404127446987
  },
  {
    "name" => "Embajada",
    "latitude" => 19.428387706258665,
    "longitude" => -99.16589256833815
  },
  {
    "name" => "IOS offices",
    "latitude" => 19.427699025686692,
    "longitude" => -99.16456232989225
  },
  {
    "name" => "The Ritz-Carlton",
    "latitude" => 19.424312745120712,
    "longitude" => -99.17567723637313
  },
  {
    "name" => "Four Seasons",
    "latitude" => 19.4232747253661,
    "longitude" =>  -99.1732232960489
  }
]
data.each do |address_data|
  PropertyAddress.create(
    name: address_data["name"],
    latitude: address_data["latitude"],
    longitude: address_data["longitude"]
  )
end

puts 'End creating Property Addresses'

# Properties
puts "start creating Properties"
urls = [
  "https://picsum.photos/id/1040/630",
  "https://images.freeimages.com/images/large-previews/e85/house-1224030.jpg",
  "https://media.istockphoto.com/photos/new-housing-estate-with-underground-garage-picture-id1287012612?s=612x612",
  "https://images.freeimages.com/images/large-previews/d5b/home-1224274.jpg",
  "https://ca-times.brightspotcdn.com/dims4/default/a37c788/2147483647/strip/true/crop/8124x5369+0+0/resize/1200x793!/format/webp/quality/75/?url=https%3A%2F%2Fcalifornia-times-brightspot.s3.amazonaws.com%2F55%2F48%2Fd9de1c9d4501abdf4ed684edf16e%2F937559-sd-co-granny-reno-ec-007.jpg",
  "https://media.admagazine.com/photos/63fcf219308b2455d685a20c/16:9/w_1600,c_limit/CAL%20TOTXO10.jpg",
  "https://cf.bstatic.com/xdata/images/hotel/max1024x768/444399184.jpg?k=e46b590a3551490ce11d4f717f8fbbabc0e14591ebedaa42b51df8ab78aecaad&o=&hp=1",
  "https://media.admagazine.com/photos/63fcf219308b2455d685a20c/16:9/w_1600,c_limit/CAL%20TOTXO10.jpg",
  "https://www.heyhom.mx/_next/image?url=https%3A%2F%2Fheyhom-assets-2.s3.us-east-2.amazonaws.com%2Fmedia%2Fassets%2Fpostingimage%2FBZLRJW4BdusGJmzzyeu4FS.jpg&w=640&q=75",
  "https://www.heyhom.mx/_next/image?url=https%3A%2F%2Fheyhom-assets-2.s3.us-east-2.amazonaws.com%2Fmedia%2Fassets%2Fpostingimage%2FcJM3HgwbGUzRTXiJyGMXm5.jpg&w=1920&q=75",
  "https://www.heyhom.mx/_next/image?url=https%3A%2F%2Fheyhom-assets-2.s3.us-east-2.amazonaws.com%2Fmedia%2Fassets%2Fpostingimage%2FUPEmo6PU4EW3jj5nwBfFLW.JPG&w=1920&q=75",
  "https://www.heyhom.mx/_next/image?url=https%3A%2F%2Fheyhom-assets-2.s3.us-east-2.amazonaws.com%2Fmedia%2Fassets%2Fpostingimage%2FQ9qkPAyEimCZJcjRHNoh49.jpg&w=640&q=75",
  "https://www.heyhom.mx/_next/image?url=https%3A%2F%2Fheyhom-assets-2.s3.us-east-2.amazonaws.com%2Fmedia%2Fassets%2Fpostingimage%2FEdnz8B7QStX3BXEhVW8wyQ.jpg&w=640&q=75",
  "https://www.heyhom.mx/_next/image?url=https%3A%2F%2Fheyhom-assets-2.s3.us-east-2.amazonaws.com%2Fmedia%2Fassets%2Fpostingimage%2F8TR66xQ8i35QaEgFTBcE6t.jpg&w=640&q=75",
  "https://www.heyhom.mx/_next/image?url=https%3A%2F%2Fheyhom-assets-2.s3.us-east-2.amazonaws.com%2Fmedia%2Fassets%2Fpostingimage%2F7Trn9i8A7e3mAbNqxJbxxT.jpg&w=640&q=75",
  
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



