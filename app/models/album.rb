# frozen_string_literal: true

require "slug_helper"

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
    [artist.try(:name), title_was].reject(&:blank?).join(" - ") # use previous title for labels
  end

  private

  def title_candidate
    return unless title? # && lastfm_url?

    title_candidate = title.downcase
    unless title_candidate.include?(artist.name.downcase.sub(/\Athe\ /, "")) ||
           artist.name.downcase == "various artists"
      title_candidate = [artist.name, title_candidate].join(" ")
    end

    SlugHelper.filter_slug(title_candidate)
  end
end
