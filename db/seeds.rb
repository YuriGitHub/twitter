# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

AdminUser.create!(email: 'test@gmail.com', password: '1234567', password_confirmation: '1234567')

#99.times do |n|
  #email = "example-#{n+1}@railstutorial.org"
  #password = "password"
  #User.create!(name: name,
              #email: email,
              #password:              password,
              #password_confirmation: password,
              #activated: true,
              #activated_at: Time.zone.now)
#end
titles = ["Neque porro quisquam est qui dolorem ipsua dolor sit amet, consectetur"]
content = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque ultrices a risus nec aliquet. Mauris tristique posuere sodales. Nulla pharetra fringilla tristique. Cras non maximus eros. Nunc mi ipsum, cursus ut tincidunt sed, euismod vitae mauris. Quisque finibus augue quis ullamcorper pharetra. Mauris felis arcu, interdum ac ligula ac, faucibus iaculis quam. Nullam sollicitudin diam at libero lobortis tincidunt.

","Vivamus ante lacus, viverra sit amet lorem et, mollis dapibus nunc. Integer quis nunc magna. Pellentesque ultrices egestas dignissim. Praesent at ante dictum, tempor ipsum a, porttitor lorem. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Ut rutrum varius arcu, a porttitor erat dictum ut. Proin nec magna eu lorem eleifend vulputate. Nunc vitae consequat nibh.","Nullam scelerisque tincidunt lorem, ut iaculis justo. Integer ut ornare lorem, id vehicula ex. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur auctor tempus nisi, sed tempus magna ultrices quis. In maximus est et felis maximus sodales. Quisque in mi et nulla hendrerit rhoncus. Quisque eu nibh et elit placerat fringilla. Quisque quis consectetur dolor, facilisis tincidunt leo."]


10.times do |index|
    User.create(email:"login#{index+1}@email.com",login:"login#{index+1}",password:'password')
end

3.times do |index|
    Post.create(header:titles[rand(1)],text:content[rand(3)],user_id:User.find_by_login("login#{1}").id)
    Post.create(header:titles[rand(1)],text:content[rand(3)],user_id:User.find_by_login("login#{2}").id)
    Post.create(header:titles[rand(1)],text:content[rand(3)],user_id:User.find_by_login("login#{3}").id)
end

