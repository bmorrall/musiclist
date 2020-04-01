FactoryBot.define do
  factory :album do
    title { Faker::Music.album }
    artist
    genre { Faker::Music.genre }
    album_art { nil }
    year { Faker::Time.backward(days: 100_000, format: "%Y") }
    editions { nil }
  end
end
