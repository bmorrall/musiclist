# frozen_string_literal: true

class AlbumsController < ApplicationController
  include PunditErrorHandling

  before_action :authenticate_user!
  before_action :assign_album, only: %i[show edit update destroy]
  after_action :verify_authorized
  after_action :verify_policy_scoped, except: %i[new create]

  # GET /albums
  def index
    authorize Album
    @albums = policy_scope(Album).includes(:artist, :album_status)
                                 .order("artists.name, title")
                                 .page(params[:page])
    @albums = present(@albums, AlbumDecorator)
    @albums = Kaminari.paginate_array(@albums, total_count: policy_scope(Album).count)
                      .page(params[:page]).per(Album.default_per_page)
  end

  # GET /albums/1
  def show
    authorize @album
    @album = present(@album, AlbumDecorator)
  end

  # GET /albums/1/edit
  def edit
    authorize @album
  end

  # PATCH/PUT /albums/1
  def update
    authorize @album

    if @album.update(album_params)
      redirect_to @album, notice: "Album was successfully updated."
    else
      render :edit
    end
  end

  protected

  def authentication_failed_redirect_path_for(_resource)
    if @album && policy(@album).show?
      @album
    elsif policy(Album).index?
      albums_url
    else
      super
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def assign_album
    @album = policy_scope(Album).find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def album_params
    permitted_attributes(@album || Album)
  end
end
