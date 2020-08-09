class AddPlayedOnToAlbumStatuses < ActiveRecord::Migration[6.0]
  def change
    add_column :album_statuses, :played_on, :date, after: :album_id
  end
end
