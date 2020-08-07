FactoryBot.define do
  factory :album_status do
    played { false }
    purchased { false }
    album { nil }
  end
end
