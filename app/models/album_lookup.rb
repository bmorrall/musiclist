# frozen_string_literal: true

# Looks up details of an Album from Last.fm
class AlbumLookup
  def self.get_info(album)
    new.get_info(**album)
  end

  def self.search(album_name)
    new.search(album_name)
  end

  def self.default_client
    require "lastfm"
    api_key = ENV.fetch("LASTFM_API_KEY")
    api_secret = ENV.fetch("LASTFM_API_SECRET")
    Lastfm.new(api_key, api_secret)
  end

  def initialize(client = AlbumLookup.default_client)
    @lastfm = client
  end

  def get_info(artist:, album:)
    res = lastfm.album.get_info(album: album, artist: artist)
    res["image"] = OpenStruct.new(build_image_hash(res["image"]))
    res["tags"] = res.dig("tags", "tag").map { |tag| tag["name"] }
    res["wiki"] = OpenStruct.new(res["wiki"])
    OpenStruct.new(res)
  end

  def search(album_name)
    res = lastfm.album.search(album_name)
    res.dig("results", "albummatches", "album").map { |o| OpenStruct.new(o) }
  end

  private

  attr_reader :lastfm

  def build_image_hash(res_image)
    res_image.each_with_object({}) do |tag, h|
      h[tag["size"].presence || "default"] = tag["content"]
    end
  end
end
