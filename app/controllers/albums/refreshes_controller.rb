module Albums
  class RefreshesController < ::ApplicationController
    include PunditErrorHandling

    before_action :authenticate_user!
    before_action :assign_album
    before_action :authorize_refresh!
    after_action :verify_policy_scoped

    def show
      @albums = AlbumLookup.search(@album.title)
    end

    def create
      info = AlbumLookup.get_info(album: lookup_params[:album], artist: lookup_params[:artist])
      @album.update!(
        title: info.name,
        genre: info.tags.first,
        year: info.tags.detect { |t| t =~ /\A(19|20)\d{2}\z/ },
        album_art: info.image.default,
        lastfm_url: info.url,
        description: info.wiki.content
      )
      redirect_to @album, notice: "Album updated successfully."
    end

    protected

    def authorize_refresh!
      authorize @album, :refresh?
    end

    def authentication_failed_redirect_path_for(_resource)
      album_url(_resource)
    end

    private

    def assign_album
      @album = policy_scope(Album).find(params[:album_id])
    end

    def lookup_params
      params.require(:lookup).permit(:album, :artist)
    end
  end
end
