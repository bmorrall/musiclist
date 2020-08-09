class RemotePlayedFromAlbumStatuses < ActiveRecord::Migration[6.0]
  def change
    remove_column :album_statuses, :played, :boolean, after: :album_id
  end
end
