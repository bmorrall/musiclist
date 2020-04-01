FactoryBot.define do
  factory :artist do
    name { Faker::Music.band }
    sort_name { name.downcase }
  end
end
