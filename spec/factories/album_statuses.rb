FactoryBot.define do
  factory :album_status do
    played_on { nil }
    purchased { false }
    album
  end
end
