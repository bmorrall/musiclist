# frozen_string_literal: true

# Looks up details of an artist from Last.fm
class ArtistLookup
  def self.get_info(artist)
    lookup = new
    name = lookup.get_correction(artist).first.name
    lookup.get_info(name)
  end

  def initialize(client = AlbumLookup.default_client)
    @lastfm = client
  end

  def get_info(artist)
    res = lastfm.artist.get_info(artist: artist)
    res["image"] = OpenStruct.new(build_image_hash(res["image"]))
    res["bio"] = OpenStruct.new(filter_wiki(res["bio"]))
    OpenStruct.new(res)
  end

  def get_correction(artist)
    lastfm.artist.get_correction(artist: artist).map { |c| OpenStruct.new(c["artist"]) }
  end

  private

  attr_reader :lastfm

  def build_image_hash(res_image)
    res_image.each_with_object({}) do |tag, h|
      h[tag["size"].presence || "default"] = tag["content"]
    end
  end

  def filter_wiki(wiki)
    return {} if wiki.nil?

    wiki["content"] = format_content(wiki["content"])
    wiki
  end

  def format_content(content)
    content.gsub(/\[\d\]/, "")
           .sub(/.*\K\s+\<a\ href/, "\n\n<a href") # find the last link, and replace with newline
           .sub(/.*\K\<a\ href/, "\n\n<a href") # find again without the preceeding newline
           .gsub(/\n\n+/, "\n\n") # two newlines at most
  end
end
