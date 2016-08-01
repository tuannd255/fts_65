User.create! name: "Admin", email: "admin@gmail.com",
  password: "1", password_confirmation: "1", is_admin: true

20.times do |n|
  name = Faker::Name
  email = "test#{n}@gmail.com"
  password = "1"
  password_confirmation = "1"
  User.create! name: name, email: email, password: password,
    password_confirmation: password_confirmation
end

Subject.create! name: "MySQL", question_number: 3, duration: 5
Subject.create! name: "Git", question_number: 3, duration: 1
Subject.create! name: "Ruby", question_number: 5, duration: 10

30.times do |n|
  name = Faker::Name.last_name
  question_number = Faker::Number.between(1, 10)
  duration = Faker::Number.between(1, 5)
  Subject.create! name: name,
    question_number: question_number,
    duration: duration
end
