FactoryBot.define do
  factory :album do
    title { Faker::Music.album }
    artist
    genre { Faker::Music.genre }
    album_art { nil }
    year { (1950..2020).to_a.sample.to_s }
  end
end
