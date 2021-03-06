# frozen_string_literal: true

class PlayedAlbumReflex < ApplicationReflex
  # Add Reflex methods in this file.
  #
  # All Reflex instances expose the following properties:
  #
  #   - connection - the ActionCable connection
  #   - channel - the ActionCable channel
  #   - request - an ActionDispatch::Request proxy for the socket connection
  #   - session - the ActionDispatch::Session store for the current visitor
  #   - url - the URL of the page that triggered the reflex
  #   - element - a Hash like object that represents the HTML element that triggered the reflex
  #   - params - parameters from the element's closest form (if any)
  #
  # Example:
  #
  #   def example(argument=true)
  #     # Your logic here...
  #     # Any declared instance variables will be made available to the Rails controller and view.
  #   end
  #
  # Learn more at: https://docs.stimulusreflex.com

  def create
    album_status = AlbumStatus.where(album: album).first_or_initialize
    authorize(album_status, :update?)
    album_status.update(played_on: Date.today)
  end

  def destroy
    album_status = AlbumStatus.where(album: album).first_or_initialize
    authorize(album_status, :update?)
    album_status.update(played_on: nil)
  end

  private

  def album
    @album ||= begin
      album_id = element.dataset["album-id"]
      Album.friendly.find(album_id)
    end
  end
end
