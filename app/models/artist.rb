class Artist < ApplicationRecord
  validates :name, presence: true
  validates :sort_name, presence: true
end
