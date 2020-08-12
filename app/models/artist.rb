class Artist < ApplicationRecord
  audited only: %i[name]

  has_many :albums, dependent: :restrict_with_exception

  validates :name, presence: true, uniqueness: true
  validates :sort_name, presence: true

  def to_s
    name_was
  end
end
