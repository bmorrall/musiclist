class Album < ApplicationRecord
  audited only: %i[title year description]

  belongs_to :artist

  validates :title, presence: true
  validates :artist_id, presence: true

  validates :year, format: /([12]\d{3})/, allow_blank: true

  def to_s
    title_was # use previous title for labels
  end
end
