# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create!(username: "bekele", email: "bekele@bekele.bekele", password: "elekeb", password_confirmation: "elekeb")
User.create!(username: "kerrek", email: "kerrek@kerrek.kerrek", password: "kerrek", password_confirmation: "kerrek")

User.all.each_with_index do |user, index|
  user.posts.create!(content: "Hello, world! #{index + 1}")
end
