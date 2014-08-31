FactoryGirl.define do
  factory :article do
    title { Faker::Lorem.word }
    text { Faker::Lorem.paragraph }
  end
end