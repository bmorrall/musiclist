# frozen_string_literal: true

# Helpers for displaying Albums
module AlbumsHelper
  def album_list_image(album)
    (album.lastfm_url? && album.album_art) || "https://via.placeholder.com/100"
  end

  def album_detail_image(album)
    (album.lastfm_url? && album.album_art) || "https://via.placeholder.com/512"
  end

  def artist_detail_image(album)
    album.profile_image || "https://via.placeholder.com/512"
  end

  def formatted_description(text)
    content_tag(:div, class: "album-description") do
      simple_format(text)
    end
  end
end
