FactoryBot.define do
  factory :album_status do
    played { false }
    purchased { false }
    album
  end
end
