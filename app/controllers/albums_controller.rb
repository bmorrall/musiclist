# frozen_string_literal: true

class AlbumsController < ApplicationController
  # GET /albums
  # GET /albums.json
  def index
    @albums = Album.includes(:artist)
  end
end
