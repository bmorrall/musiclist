# frozen_string_literal: true

class AlbumsController < ApplicationController
  # GET /albums
  # GET /albums.json
  def index
    @albums = Album.includes(:artist)
  end

  # GET /albums/1
  def show
    @album = Album.find(params[:id])
  end
end
