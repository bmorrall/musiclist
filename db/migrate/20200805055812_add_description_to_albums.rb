class AddDescriptionToAlbums < ActiveRecord::Migration[6.0]
  def change
    add_column :albums, :description, :text, after: :artist_id
  end
end
