# Create Roles
Role.create name: :administrator
Role.create name: :default_user
Role.create name: :business

#Plans
Plan.create(
  name_en: "Free",
  name_es: "Gratis",
  price: 0,
  description_en: "You can use Rewardners by uploading one promotion per month completely Free and reaching all your customers that are using the mobile application of Rewardners.",
  description_es: "Podrás tener acceso a utilizar Rewardners subiendo una promoción por mes totalmente gratis y llegarla a todos tus clientes que usan la aplicación mobil de Rewardners.",
  paypal_description_en: "Rewardners Free",
  paypal_description_es: "Rewardners Gratis"
)
Plan.create(
  name_en: "Unlimited",
  name_es: "Ilimitado",
  price: 49.99,
  description_en: "Now you can upload unlimited number of promotions that you need to publish. You can have several promotions published simultaneously and you can also publish promotions by the moment, seasonal or by opportunity. There are no limits.",
  description_es: "Ahora podrás subir en forma ilimitada el numero de promociones que necesites realizar. Puedes tener varias promociones publicadas y podrás también publicar promociones de momento, estacionales o de oportunidad. No hay limites.",
  paypal_description_en: "Rewardners Unlimited",
  paypal_description_es: "Rewardners Ilimitado"
)
Plan.create(
  name_en: "Program",
  name_es: "Programa",
  price: 59.99,
  description_en: "Rewardners Rewards Program is the easiest to use, being the most practical and inexpensive on the market. Rewardners Rewards Program allows you to receive requests from your customers after each transaction in your business, through an ordered list, which you can authorize at the same time or later during the day, you choose . Through Rewardners Rewards Program, you can get to know who is your most loyal customer, who always is coming back to your business.",
  description_es: "Rewardners Rewards Program es el mas fácil de usar, siendo el mas practico y el de bajo costo en el mercado. Rewardners Rewards Program te permite recibir solicitudes de tus clientes después de cada transacción en tu negocio, a través de una lista ordenada, donde podrás autorizarla en el mismo momento o mas adelante durante el día, tu escoges. A través de Rewardners Rewards Program, podrás ir conociendo quienes son tus clientes mas fieles que siempre regresan a tu negocio.",
  paypal_description_en: "Rewardners Program",
  paypal_description_es: "Programa Rewardners"
)
Plan.create(
  name_en: "Mobile management",
  name_es: "Gestión Móvil",
  price: 69.99,
  description_en: "With Rewardners Mobile APP Management you can manage Rewardners Unlimited and Rewardners Rewards Programs from your smart phone through the mobile application Rewardners for business, no matter where you are, you always get access to upload promotions at any time and from wherever you are. You can also give more people access to manage it.",
  description_es: "Con Rewardners Mobile APP Management podrás administrar los programas Rewardners Unlimited y Rewardners Rewards desde tu smart phone a través de la Aplicación móvil de Rewardners para negocios, no importando en todo te encuentras, siempre tendrás acceso a subir promociones en cualquier momento y desde cualquier llegar. También puedes darle acceso a mas personas a poder utilizarlo.",
  paypal_description_en: "Rewardners Mobile management",
  paypal_description_es: "Rewardners Gestión Móvil"
)

# Create admin user
admin = User.new
admin.name = "Administrator"
admin.last_name = "Rewardners"
admin.zipcode = "11111"
admin.email = "admin@test.com"
admin.password = "password"
admin.confirmed_at = DateTime.now
admin.signup_type = "administrator"
admin.save validate: false

# Create business user
business = User.new
business.name = "business"
business.last_name = "Rewardners"
business.zipcode = "11111"
business.manager = "business"
business.address = "asdasda"
business.city = "Barranquilla"
business.business_name = "Business"
business.email = "business@test.com"
business.password = "password"
business.confirmed_at = DateTime.now
business.signup_type = "business"
business.save validate: false

# Create client user
client = User.new
client.name = "client"
client.last_name = "Rewardners"
client.zipcode = "11111"
client.email = "client@test.com"
client.password = "password"
client.confirmed_at = DateTime.now
client.signup_type = "default_user"
client.save validate: false

#Create place
(1..5).to_a.each do |f|
  Place.create!({
    name:          Faker::Company.name,
    address:       Faker::Address.street_address,
    phone:         "+12015555555",
    zipcode:       "11111",
    email:         Faker::Internet.email,
    city:          Faker::Address.city,
    rewards_terms: Faker::Lorem.paragraph(2),
    latitude:      Faker::Address.latitude,
    longitude:     Faker::Address.longitude,
    user_id:       business.id,
    logo:          Faker::Avatar.image("my-own-slug", "300x300", "jpg"),
    banner:        Faker::Avatar.image("my-own-slug", "1000x300", "jpg")
  })
end

# # Create promos
# (1..5).to_a.each do |f|
#   Promo.create!({
#     name:              Faker::Name.name,
#     description:       Faker::Lorem.paragraph(2, true),
#     extra_description: Faker::Lorem.paragraph,
#     banner:            Faker::Avatar.image,
#     published:         true,
#     published_at:      Time.now,
#     place:             Place.find(f),
#     role_id:           2,
#     start_at:          Time.now,
#     end_at:            Time.now + 6.month,
#     category_id:       Category.find(f)
#   })
# end
