FactoryBot.define do
  factory :message do
    title { Faker::Games::ElderScrolls.race }
    text { Faker::Lorem.paragraph }
    author { Faker::Games::ElderScrolls.dragon }
  end
end