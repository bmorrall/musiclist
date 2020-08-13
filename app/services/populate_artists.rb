# frozen_string_literal: true

# Populates Artist information from Last.fm
class PopulateArtists
  def self.call(*args)
    new(*args).call
  end

  def initialize(artists = Artist.where(lastfm_url: nil))
    @artists = artists
  end

  def call
    @artists.find_each do |artist|
      puts "Updating #{artist.name}"
      info = ArtistLookup.get_info(artist.name)

      unless valid_names(artist).include?(info.name)
        raise "Mismatch on artist name: #{info.name.inspect}"
      end

      UpdateArtistInfo.call(artist, info)
    end
  end

  def valid_names(artist)
    names = [artist.name, "The #{artist.name}", "A #{artist.name}"]
    names.push(*names.map { |name| name.gsub("&", "and") })
    names.push(*names.map { |name| name.gsub("and", "and The") })
    names.push(*names.map { |name| name.gsub(/\band\b/, "&") })
    names.push(*names.map { |name| name.gsub(/\bThe\b/, "the") })
    names.push(*names.map { |name| name.gsub(/\bthe\b/, "the") })
    names.push(*names.map { |name| name.gsub(/\b[a-zA-Z]{2,3}\b/) { |w| w.upcase } })
    names.push(*names.map { |name| name.gsub(/\bOf\b/, "of") })
    names.uniq
  end
end
