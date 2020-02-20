FactoryBot.define do
  factory :user, class: User do
    name { Faker::Lorem.word }
    password { 'foobar' }
  end
end