# frozen_string_literal: true

# Helpers for displaying Albums
module AlbumsHelper
  def album_list_image(album)
    (album.lastfm_url? && album.album_art) || "https://via.placeholder.com/100"
  end

  def album_detail_image(album)
    (album.lastfm_url? && album.album_art) || "https://via.placeholder.com/512"
  end

  def album_simple_format(text)
    content_tag(:div, class: "album-description") do
      simple_format(text)
    end
  end

  def small_album_played_button
    small_played_button_with_style("bg-orange-400 text-white border-orange-400")
  end

  def small_album_unplayed_button
    small_played_button_with_style("bg-white text-gray-400 border-gray-400")
  end

  private

  def small_played_button_with_style(style)
    content_tag(:span, class: "#{style} text-sm font-semibold py-0 px-2 border rounded shadow") do
      concat content_tag(:span, "", class: "fa fa-music mr-2")
      concat "Played"
    end
  end
end
