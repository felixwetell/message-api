FactoryBot.define do
  factory :user, class: User do
    name { Faker::Games::ElderScrolls.name }
    password { Faker::Company.buzzword }
  end
end