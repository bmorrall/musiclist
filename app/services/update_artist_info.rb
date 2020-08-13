# frozen_string_literal: true

# Updates an Artist from info collected from the Last.fm API
class UpdateArtistInfo
  def self.call(*args)
    new(*args).call
  end

  def initialize(artist, info)
    @artist = artist
    @info = info
  end

  def call
    artist.update!(
      name: info.name,
      profile_image: info.image.default,
      lastfm_url: info.url,
      description: info.bio.content
    )
  end

  private

  attr_reader :artist, :info
end
