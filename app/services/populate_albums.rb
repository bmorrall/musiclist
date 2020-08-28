# frozen_string_literal: true

# Populates Album information from Last.fm
class PopulateAlbums
  def self.call(*args)
    new(*args).call
  end

  def initialize(albums = Album.where(lastfm_url: nil).joins(:artist))
    @albums = albums
  end

  def call
    @albums.shuffle.each do |album|
      puts "Updating #{album.title}"

      titles = valid_titles(album)

      candidate = filter_candidates(AlbumLookup.search(album.title), album, titles)
      candidate ||= filter_candidates(AlbumLookup.search("#{album.artist.name} #{album.title}"), album, titles)

      if candidate.nil?
        puts "Unable to find matching album"
        next
      end

      info = AlbumLookup.get_info(album: candidate.name, artist: album.artist.name)

      unless valid_titles(album).include?(info.name)
        puts "Mismatch on album title: #{info.name.inspect}"
        next
      end

      UpdateAlbumInfo.call(album, info)
    end
  end

  def filter_candidates(candidates, album, titles)
    candidates.reject { |a| a.artist != album.artist.name }
              .detect { |a| titles.include?(a.name) }
  end

  def valid_titles(album)
    titles = [album.title, "The #{album.title}", "A #{album.title}"]
    titles.push(*titles.map { |title| title.gsub("&", "and") })
    titles.push(*titles.map { |title| title.gsub("and", "and The") })
    titles.push(*titles.map { |title| title.gsub(/\band\b/, "&") })
    titles.push(*titles.map { |title| title.gsub(/\bThe\b/, "the") })
    titles.push(*titles.map { |title| title.gsub(/\bthe\b/, "the") })
    titles.push(*titles.map { |title| title.gsub(/\b[a-zA-Z]{2,3}\b/) { |w| w.upcase } })
    titles.push(*titles.map { |title| title.gsub(/\bOf\b/, "of") })
    titles.uniq
  end
end
