# frozen_string_literal: true

require "content_utils"

# Looks up details of an Album from Last.fm
class AlbumLookup
  USELESS_TAGS = [
    "1001 Albums You Must Hear Before You Die",
    "1979",
    "albums I own",
    "albums I own",
    "ambient",
    "beatles",
    "bibibi",
    "BLUEZZZ",
    "british",
    "cuba",
    "dark",
    "elton john",
    "favorite albums",
    "favourite albums",
    "female vocalists",
    "golden age hip hop",
    "gotanygoodmusic",
    "John Frusciante",
    "kinks",
    "Linda Rondstat",
    "old school rap",
    "oldies",
    "Otis Redding",
    "piano",
    "rod stewart",
    "role certo",
    "rolling stone 500 greatest albums of all time",
    "Rolling Stone 500 Greatest Albums",
    "rs500 album",
    "RS500best",
    "singer-songwriter",
    "steely dan",
    "stuzzie",
    "the best",
    "U2",
    "UK",
    "various artists",
    "vh1 100 greatest albums",
    "Vocal"
  ].map(&:downcase).freeze

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
    res_tags = res.dig("tags", "tag") || []
    res["image"] = OpenStruct.new(build_image_hash(res["image"]))
    res["tags"] = filter_tags(res_tags)
    res["wiki"] = OpenStruct.new(filter_wiki(res["wiki"]))
    res["year"] = ContentUtils.extract_year(res["wiki"].content) || filter_year(res_tags)
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

  def filter_year(tags)
    tags.map { |tag| tag["name"] }
        .detect { |t| t =~ /\A(19|20)\d{2}\z/ }
  end

  def filter_tags(tags)
    tags.map { |tag| tag["name"].downcase }
        .reject { |t| t =~ /\A\d{2}s\z/ } # 50s, 60s, etc
        .reject { |t| t =~ /\A(19|20)\d{2}\z/ } # 1996, 2001, etc
        .reject { |t| USELESS_TAGS.include?(t) }
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
