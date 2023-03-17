Faker::UniqueGenerator.clear
ActionMailer::Base.perform_deliveries = false
User.destroy_all
Item.destroy_all
Order.destroy_all
Cart.destroy_all
OrderItem.destroy_all
Category.destroy_all

User.create!(email: 'my_admin_mailer@yopmail.com', password: 'foobar', admin: true)

10.times do |_|
  User.create!(email: Faker::Internet.email,
               password: 'foobar',
               admin: false)
end

5.times do |_|
  Category.create(name: Faker::Hobby.activity)
end

IMG_URLS = [
  'https://i.imgur.com/V5SMnVj.png',
  'https://i.imgur.com/fvMc5Xb.png',
  'https://i.imgur.com/sJipia0.png',
  'https://i.imgur.com/Gab4IhW.png',
  'https://i.imgur.com/1B4RDno.png',
  'https://i.imgur.com/HzbvQ5W.png',
  'https://i.imgur.com/BrvJ9YA.png',
  'https://i.imgur.com/16EcvCa.png',
  'https://i.imgur.com/iP10wZu.png',
  'https://i.imgur.com/zWA6lod.png',
  'https://i.imgur.com/S1dlqF3.png',
  'https://i.imgur.com/Si2Gbzj.png',
  'https://i.imgur.com/UIMUpRO.png',
  'https://i.imgur.com/miTsjok.png',
  'https://i.imgur.com/OfM933a.png',
  'https://i.imgur.com/xI1uEAB.png',
  'https://i.imgur.com/06diV7d.png',
  'https://i.imgur.com/EWsGFUF.png',
  'https://i.imgur.com/DRO5r6X.png',
  'https://i.imgur.com/m6yPeUp.png',
  'https://i.imgur.com/HmMHAEd.png',
]
RARITY_PRICE_FACTOR = [1, 2, 5, 10, 100]
21.times do |i|
  item = Item.new(title: Faker::Games::Pokemon.unique.name,
                  category: Category.all.sample,
                  description: Faker::Lorem.paragraph,
                  image_url: IMG_URLS[i],
                  rarity: rand(0..4))

  item.price = (format('%.02f', (RARITY_PRICE_FACTOR[item.rarity] * rand(1.0..50.0))))
  item.save!
end
