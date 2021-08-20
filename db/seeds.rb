# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.destroy_all
Like.destroy_all
Tagging.destroy_all
Tag.destroy_all
User.destroy_all
Product.destroy_all
Review.destroy_all

PASSWORD='0414'
super_user=User.create(
    first_name: 'Joseph',
    last_name: 'Son',
    email: 'sms0330@gmail.com',
    address: '628 6th Avenue, New Westminster, BC, Canada',
    password: PASSWORD,
    is_admin: true
)

10.times do
    first_name=Faker::Name.first_name
    last_name=Faker::Name.last_name
    User.create(
        first_name: first_name,
        last_name: last_name,
        email: "#{first_name}.#{last_name}@example.com",
        address: Faker::Address.street_address,
        password: PASSWORD
    )
end
users=User.all

NUM_TAGS = 20

NUM_TAGS.times do
    Tag.create(
        name: Faker::Vehicle.make
    )
end

tags = Tag.all

100.times do
    created_time = Faker::Date.backward(days:365 * 5)
    p = Product.create(
        title: Faker::Vehicle.make_and_model,
        description: Faker::Vehicle.standard_specs,
        price: rand(100_000),
        created_at: created_time,
        updated_at: created_time,
        user: users.sample
    )
    if p.valid?
        rand(0..10).times.map do
        r = Review.create(
            body: Faker::GreekPhilosophers.quote,
            rating: rand(1..5),
            user: users.sample,
            product: p
        )
        r.likers = users.shuffle.slice(0, rand(users.count))
        end
    end
    p.tags = tags.shuffle.slice(0, rand(tags.count))
end

products = Product.all
reviews = Review.all


puts products.count
puts reviews.count

puts Cowsay.say("Generated #{products.count} products", :tux)
puts Cowsay.say("Generated #{reviews.count} reviews", :koala)
puts Cowsay.say("Generated #{users.count} users", :beavis)
puts Cowsay.say("Login with #{super_user.email} and password: #{PASSWORD}", :frogs)
puts Cowsay.say("Generated #{Like.count} likes", :cow)
puts Cowsay.say("Generated #{Tag.count} tags", :bunny)