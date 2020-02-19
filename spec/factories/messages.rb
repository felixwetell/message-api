FactoryBot.define do
  factory :message, class: Message do
    title { Faker::Games::ElderScrolls.race }
    text { Faker::Lorem.paragraph }
    author { Faker::Games::ElderScrolls.dragon }
  end
end