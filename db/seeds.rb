p '==================== customer create ===================='
unless Customer.exists?(email: "yamada.taro@gmail.com")
  Customer.create!(name: "Yamada Taro", email: "yamada.taro@gmail.com", password: "111111")
end
unless Customer.exists?(email: "sato.mamoru@gmail.com")
  Customer.create!(name: "Sato Mamoru", email: "sato.mamoru@gmail.com", password: "111111")
end
unless Customer.exists?(email: "tanaka.saki@gmail.com")
  Customer.create!(name: "Tanaka Saki", email: "tanaka.saki@gmail.com", password: "111111")
end
unless Customer.exists?(email: "hoshino.yui@gmail.com")
  Customer.create!(name: "Hoshino Yui", email: "hoshino.yui@gmail.com", password: "111111")
end
unless Customer.exists?(email: "saito.kazuma@gmail.com")
  Customer.create!(name: "Saito Kazuma", email: "saito.kazuma@gmail.com", password: "111111")
end

p '==================== admin create ===================='
unless Admin.exists?(email: "admin@gmail.com")
  Admin.create!(email: "admin@gmail.com", password: "1234qwer")
end

p '==================== product create ===================='
product1 = Product.new(
  name: "candle",
  description: "By using a wooden wick, you can enjoy a sound like a bonfire, a sound that cannot be experienced with ordinary candles.", 
  price: 3500, 
  stock: 5
)
product1.image.attach(io: File.open(Rails.root.join('app/assets/images/candle00.jpg')), filename: 'hat.jpg')
product1.save!

product2 = Product.new(
  name: "Incense",
  description: "It has a fresh, soapy fragrance.", 
  price: 2500, 
  stock: 20
)
product2.image.attach(io: File.open(Rails.root.join('app/assets/images/incense.jpg')), filename: 'jacket.jpg')
product2.save!
