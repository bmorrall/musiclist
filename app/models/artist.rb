class Artist < ApplicationRecord
  audited only: %i[name]

  extend FriendlyId
  friendly_id :slug_candidates

  has_many :albums, dependent: :restrict_with_exception

  validates :name, presence: true, uniqueness: true

  def slug_candidates
    [
      -> { name && name.gsub("&", "and") }
    ]
  end

  def to_s
    name_was
  end
end
