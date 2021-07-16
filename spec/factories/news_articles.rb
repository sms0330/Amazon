FactoryBot.define do
  RANDOM_HUNDRED_CHARS = "hello world hello world hello world hello world hello world hello world hello world hello hello worl hello world hello world"
  factory :news_article do
    sequence(:title) {|n| Faker::Job.title + " #{n}"} #sequence is a method provided by factory-bot which accepts a lambda injecting a variable n. n is usually a number that factory-bot increments on every object it generates so we can use it to make sure all instances created are unique
    description { Faker::Job.field + "-#{RANDOM_HUNDRED_CHARS}"}
    published_at { Faker::Date.between(from: '2021-05-31', to: '2021-07-31')}
    view_count { Faker::Number.within(range: 1..100)}
  end

  #FactoryBot.create(:job_post) #Will create the object and save it to the db
  #FactoryBot.build(:job_post) #Will create the object like .new but not save it to the db
  #FactoryBot.attributes_for(:job_post) #Will generate only attributes for job_post
end
