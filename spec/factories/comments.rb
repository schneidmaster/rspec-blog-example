FactoryGirl.define do
  factory :comment do
    commenter { Faker::Name.name }
    body { Faker::Lorem.paragraph }
    article
    user
  end
end