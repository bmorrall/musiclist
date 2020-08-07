class AlbumStatus < ApplicationRecord
  belongs_to :album
  validates_presence_of :album_id
  validates_uniqueness_of :album_id
end
