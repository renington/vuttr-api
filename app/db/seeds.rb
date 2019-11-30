puts "Adicionando os usuários iniciais"
User.create(email: 'test@test.com', password: '123456789')

puts "Adicionando tags iniciais"
Tag.create([
    { name: "api" },
    { name: "json" },
    { name: "collaboration" },
    { name: "calendar" },
    { name: "node" }
])