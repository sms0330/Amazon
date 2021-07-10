# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Product.destroy_all

1000.times do
    created_at = Faker::Date.backward(days:365 * 5)
        p = Product.create(
        title: Faker::Vehicle.make_and_model,
        description: Faker::Vehicle.standard_specs,
        price: rand(100_000),
        created_at: created_at,
        updated_at: created_at
        )
        if p.persisted?
            p.reviews = rand(1..10).times.map do
                Review.new(rating: Faker::Number.between(1, 5), body: Faker::GreekPhilosophers.quote)
            end
        end
end

products = Product.all
reviews = Review.all

puts Cowsay.say("Generated #{products.count} products", :tux)

puts Cowsay.say("Generated #{reviews.count} reviews", :koala)