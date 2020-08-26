class ArtistsController < ApplicationController
  include PunditErrorHandling

  before_action :authenticate_user!, except: %i[index show]
  before_action :assign_artist, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized
  after_action :verify_policy_scoped, except: [:new, :create]

  # GET /artists
  # GET /artists/page/1
  def index
    authorize Artist
    @artists = policy_scope(Artist).left_outer_joins(:albums)
                .select('artists.*, COUNT(albums.*) as album_count').group("artists.id")
                .order(:name).page params[:page]
  end

  # GET /artists/1
  def show
    authorize @artist
    @albums = policy_scope(@artist.albums)
    @albums = present(@albums.includes(:album_status).order(:year, :title), AlbumDecorator)
    @artist = present(@artist, ArtistDecorator)
  end

  # GET /artists/new
  def new
    @artist = Artist.new
    authorize @artist
  end

  # GET /artists/1/edit
  def edit
    authorize @artist
  end

  # POST /artists
  def create
    @artist = Artist.new(artist_params)
    authorize @artist

    if @artist.save
      redirect_to @artist, notice: 'Artist was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /artists/1
  def update
    authorize @artist

    if @artist.update(artist_params)
      redirect_to @artist, notice: 'Artist was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /artists/1
  def destroy
    authorize @artist

    @artist.destroy
    redirect_to artists_url, notice: 'Artist was successfully destroyed.'
  end

  protected

  def authentication_failed_redirect_path_for(_resource)
    if @artist && policy(@artist).show?
      @artist
    elsif policy(Artist).index?
      artists_url
    else
      super
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def assign_artist
      @artist = policy_scope(Artist).friendly.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def artist_params
      permitted_attributes(@artist || Artist)
    end
end
