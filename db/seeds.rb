#User.create!(email: 'admin@example.com', password: 'admin@example.com', password_confirmation: 'admin@example.com')

PublicActivity.enabled = false
30.times do
  Course.create!([{
    title: Faker::Educator.course_name,
    description: Faker::TvShows::GameOfThrones.quote,
    user_id: User.first.id,
    short_description: Faker::Quote.famous_last_words,
    language: Faker::ProgrammingLanguage.name,
    level: 'Beginner',
    price: Faker::Number
  }])
end
PublicActivity.enabled = true
