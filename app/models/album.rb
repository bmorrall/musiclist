class Album < ApplicationRecord
  belongs_to :artist

  validates :title, presence: true
  validates :artist_id, presence: true

  validates :year, format: /([12]\d{3})/, allow_blank: true
end
