class Album < ApplicationRecord
  # Allow Pagination of Testme collections
  paginates_per 40

  audited only: %i[title year description]

  extend FriendlyId
  friendly_id :title_candidate

  belongs_to :artist

  has_one :album_status

  validates :title, presence: true
  validates :artist_id, presence: true

  validates :year, format: /([12]\d{3})/, allow_blank: true

  def to_s
    title_was # use previous title for labels
  end

  private

  COMMON_ALBUM_TITLES = [
    "collection",
    "greatest hits",
    "anthology"
  ]

  def title_candidate
    return unless title? && lastfm_url?

    title_candidate = title
    if COMMON_ALBUM_TITLES.any? { |common_title| title.downcase.include?(common_title) }
      title_candidate = [artist.name, title_candidate].join(" ")
    end

    title_candidate.gsub("&", "and")
  end
end
