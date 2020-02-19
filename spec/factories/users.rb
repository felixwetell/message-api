FactoryBot.define do
  factory :user do
    name { Faker::Games::ElderScrolls.name }
    password { Faker::Company.buzzword }
  end
end