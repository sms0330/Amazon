FactoryBot.define do
  factory :pay do
    sender_id { 1 }
    receiver_id { 1 }
    amount { 1 }
    status { "MyString" }
    security_key { "MyText" }
    product { nil }
  end
end
