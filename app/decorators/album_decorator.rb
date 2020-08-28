# frozen_string_literal: true

# Decorator methods for Album
class AlbumDecorator
  def initialize(album, view_context)
    @album = album
    @view_context = view_context
  end

  delegate :to_param, :to_s, to: :album

  def played_button
    if played?
      label = @album.album_status.played_on.strftime("Played on %b %Y")
      v.large_orange_button(label, "#", "fa fa-music")
    else
      v.large_disabled_button("Played", "#", "fa fa-music")
    end
  end

  def small_played_button
    if played?
      v.small_orange_button("Played", "#", "fa fa-music")
    else
      v.small_disabled_button("Played", "#", "fa fa-music")
    end
  end

  def purchased_button
    if purchased?
      v.large_green_button("Purchased", "#", "fa fa-compact-disc")
    else
      v.large_disabled_button("Purchased", "#", "fa fa-compact-disc")
    end
  end

  def small_purchased_button
    if purchased?
      v.small_green_button("Purchased", "#", "fa fa-compact-disc")
    else
      v.small_disabled_button("Purchased", "#", "fa fa-compact-disc")
    end
  end

  def played?
    @album.album_status.try(:played_on?) && true
  end

  def purchased?
    @album.album_status.try(:purchased?) && true
  end

  # Pundit policy object
  def policy
    v.policy(album)
  end

  def artist_name
    album.artist.try(:name)
  end

  def description
    return unless album.description?

    v.formatted_description(album.description)
  end

  def small_album_image(*args)
    v.image_tag v.album_list_image(@album), { alt: @album.title }.merge(*args)
  end

  def method_missing(method_name, *args, &block)
    if @album.respond_to?(method_name, false)
      @album.send(method_name, *args, &block)
    else
      super
    end
  end

  def respond_to_missing?(method_name, include_private = false)
    @album.respond_to?(method_name, false) || super
  end

  private

  attr_reader :album, :view_context
  alias v view_context
end
