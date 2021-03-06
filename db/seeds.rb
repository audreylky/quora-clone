require 'faker'

5.times do |i|
  User.create(full_name: Faker::Name.unique.name, email: Faker::Internet.unique.email, password: "1q2w3e4r5t")
end

15.times do |i|
	id = (1..5).to_a.sample
	Question.create(text: Faker::Lorem.sentence, user_id: id)
end