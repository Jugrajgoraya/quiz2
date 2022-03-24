# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Idea.destroy_all
Review.destroy_all
User.destroy_all

PASSWORD = 'abcd'
super_user = User.create(
    name: 'yuvi',
    email: 'yuvi@goraya.com',
    password: PASSWORD,
    is_admin: true
)
5.times do
    name = Faker::Name.first_name
    User.create(
        name: name,
        email: "#{name}@123.com",
        password: PASSWORD
    )
end
users = User.all

20.times do
    created_at = Faker::Date.backward(days:365*4)

    i = Idea.create(
        title: Faker::Hacker.say_something_smart,
        description: Faker::ChuckNorris.fact,
        created_at: created_at,
        updated_at: created_at,
        user: users.sample 
    )
    if i.valid?
        rand(1..5).times do
            Review.create(body: Faker::Hacker.say_something_smart, idea: i, user: users.sample )
        end
    end
end

ideas = Idea.all
reviews = Review.all
users = User.all

puts Cowsay.say("Generated #{ideas.count} ideas", :cow)
puts Cowsay.say("Generated #{reviews.count} reviews", :frogs)
puts Cowsay.say("Generated #{users.count} users", :koala)