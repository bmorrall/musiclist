class ChangeOrderToPositionForPlaylistAlbums < ActiveRecord::Migration
  def up
    rename_column :playlist_albums, :order, :position
  end

  def down
    rename_column :playlist_albums, :position, :order
  end
end
