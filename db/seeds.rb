# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.new(
  first_name: "Oluwakunle",
  last_name: "Fakorede",
  email: "oluwakunle@example.com",
  password: "password",
  password_confirmation: "password"
)
user.save!

["nature1", "nature2", "nature3", "nature4", "nature5", "nature6"].each do |file_name|
  article = Article.new(
    title: "Dummy Article",
    description: "Donec sed odio dui. Maecenas sed diam eget risus varius blandit sit amet non magna.",
    body: "Suspendisse iaculis est ac sem rutrum, ut ultricies nulla vestibulum. Donec pretium, diam eget ultricies placerat, felis odio vulputate ante, quis elementum mi est ut odio. Fusce hendrerit enim neque, ac semper tortor accumsan sit amet. Curabitur efficitur ante nisi, a egestas nunc bibendum id. Proin aliquet gravida lacinia. Maecenas vestibulum tortor ut aliquet ultrices. Donec in egestas enim, non aliquam lectus. Phasellus quam eros, commodo in est nec, varius pulvinar est. Morbi et condimentum lectus. Mauris egestas, metus sed cursus tempus, dolor nibh iaculis diam, et condimentum lorem purus quis dui. Nunc malesuada tempor dui, quis pellentesque urna vehicula tincidunt. Nullam hendrerit purus id ipsum ultrices ultricies. Suspendisse malesuada feugiat ligula, non ornare sapien placerat tristique. Duis mi turpis, eleifend vitae felis at, convallis ullamcorper est.
Quisque diam augue, consequat ac egestas rhoncus, ornare in sapien. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Ut nec consequat lorem, ut eleifend justo. Duis elementum feugiat dolor vel vulputate. Aenean dignissim neque in enim convallis consequat. Nam porta leo justo, a pulvinar odio euismod vel. Fusce mauris nulla, eleifend vitae accumsan sit amet, faucibus nec mi.",
    user_id: user.id
  )

  article.image.attach(
    io: File.open(Rails.root.join("app/assets/images/#{file_name}.jpeg")),
    filename: 'micropost_placeholder.jpeg',
    content_type: 'image/jpeg'
  )
  article.save!
  article.published!
end
