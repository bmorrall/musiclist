# frozen_string_literal: true

# Updates an Album from info collected from the Last.fm API
class UpdateAlbumInfo
  def self.call(*args)
    new(*args).call
  end

  def initialize(album, info)
    @album = album
    @info = info
  end

  def call
    album.update!(
      title: info.name,
      genre: info.tags.first,
      year: info.year,
      album_art: info.image.default,
      lastfm_url: info.url,
      description: info.wiki.content
    )
  end

  private

  attr_reader :album, :info
end
