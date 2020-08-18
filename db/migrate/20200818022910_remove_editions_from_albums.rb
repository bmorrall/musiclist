class RemoveEditionsFromAlbums < ActiveRecord::Migration[6.0]
  def change
    remove_column :albums, :editions, :text
  end
end
