# frozen_string_literal: true

# Decorator methods for Artist
class ArtistDecorator
  def initialize(artist, view_context)
    @artist = artist
    @view_context = view_context
  end

  delegate :to_param, to: :artist

  # Pundit policy object
  def policy
    v.policy(artist)
  end

  def description
    return unless artist.description?

    v.formatted_description(artist.description)
  end

  def method_missing(method_name, *args, &block)
    if @artist.respond_to?(method_name, false)
      @artist.send(method_name, *args, &block)
    else
      super
    end
  end

  def respond_to_missing?(method_name, include_private = false)
    @artist.respond_to_missing?(method_name, false) || super
  end

  private

  attr_reader :artist, :view_context
  alias v view_context
end
