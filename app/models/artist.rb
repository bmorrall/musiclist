class Artist < ApplicationRecord
  has_many :albums, dependent: :restrict_with_exception

  validates :name, presence: true
  validates :sort_name, presence: true
end
