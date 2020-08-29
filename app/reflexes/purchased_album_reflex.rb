class PurchasedAlbumReflex < StimulusReflex::Reflex
  def create
    album_status = AlbumStatus.where(album: album).first_or_initialize
    album_status.update(purchased: true)
  end

  def destroy
    album_status = AlbumStatus.where(album: album).first_or_initialize
    album_status.update(purchased: false)
  end

  private

  def album
    @album ||= begin
      album_id = element.dataset["album-id"]
      Album.friendly.find(album_id)
    end
  end
end
