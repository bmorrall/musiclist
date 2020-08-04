# frozen_string_literal: true

# Looks up details of an Album from Last.fm
class AlbumLookup
  def self.search(album_name)
    require "lastfm"
    api_key = ENV.fetch("LASTFM_API_KEY")
    api_secret = ENV.fetch("LASTFM_API_SECRET")
    lastfm = Lastfm.new(api_key, api_secret)
    new(lastfm).search(album_name)
  end

  def initialize(client)
    @lastfm = client
  end

  def search(album_name)
    res = lastfm.album.search(album_name)
    res.dig("results", "albummatches", "album").map { |o| OpenStruct.new(o) }
  end

  private

  attr_reader :lastfm
end
