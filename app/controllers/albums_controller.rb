# frozen_string_literal: true

class AlbumsController < ApplicationController
  # GET /albums
  # GET /albums.json
  def index
    @albums = policy_scope(Album).includes(:artist)
                                 .order("artists.name, title")
  end

  # GET /albums/1
  def show
    @album = policy_scope(Album).find(params[:id])
  end
end
