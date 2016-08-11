# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

AdminUser.create!(email: 'test@gmail.com', password: '1234567', password_confirmation: '1234567')

10.times do |b|
  User.create!(first_name:"first name#{b}",
               last_name:"last_name#{b}",
               login: "login#{b}",
               email: "email#{b}@mail.com",
               password:"12345678#{b}")
end

