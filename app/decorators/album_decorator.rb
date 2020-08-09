# frozen_string_literal: true

# Decorator methods for Album
class AlbumDecorator
  def initialize(album, view_context)
    @album = album
    @view_context = view_context
  end

  delegate :to_param, to: :album

  def played_button
    if played?
      v.album_played_button
    else
      v.album_unplayed_button
    end
  end

  def small_played_button
    if played?
      v.small_album_played_button
    else
      v.small_album_unplayed_button
    end
  end

  def purchased_button
    if purchased?
      v.album_purchased_button
    else
      v.album_unpurchased_button
    end
  end

  def small_purchased_button
    if purchased?
      v.small_album_purchased_button
    else
      v.small_album_unpurchased_button
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

    v.album_simple_format(album.description)
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
    @album.respond_to_missing?(method_name, false) || super
  end

  private

  attr_reader :album, :view_context
  alias v view_context
end
