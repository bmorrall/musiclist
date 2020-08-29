class PurchasedAlbumReflex < StimulusReflex::Reflex
  def increment
    album_id = element.dataset[:"album-id"]
    return if album_id.blank?

    album = Album.friendly.find(album_id)
    album_status = AlbumStatus.where(album: album).first_or_initialize
    album_status.update(purchased: true)
  end

  def decrement
    album_id = element.dataset[:"album-id"]
    return if album_id.blank?

    album = Album.friendly.find(album_id)
    album_status = AlbumStatus.where(album: album).first_or_initialize
    album_status.update(purchased: false)
  end
end
