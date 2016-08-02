User.create! name: "Admin", email: "admin@gmail.com",
  password: "1", password_confirmation: "1", is_admin: true

20.times do |n|
  name = Faker::Name.name
  email = "test#{n}@gmail.com"
  password = "1"
  password_confirmation = "1"
  User.create! name: name, email: email, password: password,
    password_confirmation: password_confirmation
end

Subject.create! name: "MySQL", question_number: 3, duration: 20
Subject.create! name: "Git", question_number: 3, duration: 15
Subject.create! name: "Ruby", question_number: 5, duration: 20

subjects = Subject.all
subjects.each do |subject|
  5.times do
    subject.questions.build(
      question: Faker::Lorem.sentence,
      question_type: 0).save
  end
  5.times do
    subject.questions.build(
      question: Faker::Lorem.sentence,
      question_type: 1).save
  end
end

questions = Question.all
questions.single_choice.each do |question|
  question.answers.build(answer: Faker::Lorem.characters(5),
    is_correct: true).save
  question.answers.build(answer: Faker::Lorem.characters(5),
    is_correct: false).save
  question.answers.build(answer: Faker::Lorem.characters(5),
    is_correct: false).save
  question.answers.build(answer: Faker::Lorem.characters(5),
    is_correct: false).save
end
questions.multiple_choice.each do |question|
  question.answers.build(answer: Faker::Lorem.characters(5),
    is_correct: true).save
  question.answers.build(answer: Faker::Lorem.characters(5),
    is_correct: false).save
  question.answers.build(answer: Faker::Lorem.characters(5),
    is_correct: true).save
  question.answers.build(answer: Faker::Lorem.characters(5),
    is_correct: false).save
end
