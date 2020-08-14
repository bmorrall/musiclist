# frozen_string_literal: true

module Albums
  class ReloadsController < ::ApplicationController
    include PunditErrorHandling

    before_action :authenticate_user!
    before_action :assign_album
    before_action :authorize_refresh!
    after_action :verify_policy_scoped

    def create
      info = AlbumLookup.get_info(artist: @album.artist.name, album: @album.title)
      UpdateAlbumInfo.call(@album, info)
      redirect_to @album, notice: "Album updated successfully."
    end

    protected

    def authorize_refresh!
      authorize @album, :refresh?
    end

    def authentication_failed_redirect_path_for(resource)
      album_url(resource)
    end

    private

    def assign_album
      @album = policy_scope(Album).find(params[:album_id])
    end
  end
end
