# frozen_string_literal: true

# Helpers for displaying Albums
module AlbumsHelper
  INACTIVE_BUTTON_STYLES = "bg-white text-gray-400 border-gray-400"
  PLAYED_BUTTON_STYLES = "bg-orange-400 text-white border-orange-400"

  LARGE_BUTTON_STYLES = "text-lg py-1 px-4"
  SMALL_BUTTON_STYLES = "text-sm py-0 px-2"

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

  def album_played_button
    album_button_with_styles(PLAYED_BUTTON_STYLES, LARGE_BUTTON_STYLES)
  end

  def small_album_played_button
    album_button_with_styles(PLAYED_BUTTON_STYLES, SMALL_BUTTON_STYLES)
  end

  def album_unplayed_button
    album_button_with_styles(INACTIVE_BUTTON_STYLES, LARGE_BUTTON_STYLES)
  end

  def small_album_unplayed_button
    album_button_with_styles(INACTIVE_BUTTON_STYLES, SMALL_BUTTON_STYLES)
  end

  private

  def album_button_with_styles(*styles)
    content_tag(:span, class: ["inline-block font-semibold border rounded shadow", *styles].join(" ")) do
      concat content_tag(:span, "", class: "fa fa-music mr-2")
      concat "Played"
    end
  end
end
