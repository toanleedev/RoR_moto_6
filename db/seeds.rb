# rails db:seed
# User.create!(email: 'admin@gmail.com', first_name: 'admin', last_name: 'group', is_admin: true, encrypted_password: '242112')

brands = ['Honda', 'Yamaha', 'Suzuki', 'SYM', 'Piaggio']
types = [
  {vi: 'Xe số', en: 'Motorbike'},
  {vi: 'Xe ga', en: 'Scooter'},
  {vi: 'Xe côn', en: 'Motor Clutch'}
]
engines = ['< 50cc', '50cc - 125cc', '125cc - 175cc', '> 175cc']

brands.each do |brand|
  VehicleOption.create!(key: 'BRAND', name_vi: brand, name_en: brand)
end
types.each do |type|
  VehicleOption.create!(key: 'TYPE', name_vi: type[:vi], name_en: type[:en])
end
engines.each do |engine|
  VehicleOption.create!(key: 'ENGINE', name_vi: engine, name_en: engine)
end
