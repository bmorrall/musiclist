module Albums
  class RefreshesController < ::ApplicationController
    before_action :fetch_album

    def show
      @albums = AlbumLookup.search(@album.title)
    end

    def create
      info = AlbumLookup.get_info(album: lookup_params[:album], artist: lookup_params[:artist])
      @album.update!(
        title: info.name,
        genre: info.tags.first,
        year: info.tags.detect { |t| t =~ /\A(19|20)\d{2}\z/ },
        description: info.wiki.content
      )
      redirect_to @album, notice: "Album updated successfully."
    end

    private

    def fetch_album
      @album = Album.find(params[:album_id])
    end

    def lookup_params
      params.require(:lookup).permit(:album, :artist)
    end
  end
end
