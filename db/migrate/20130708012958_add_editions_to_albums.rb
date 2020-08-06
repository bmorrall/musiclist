class AddEditionsToAlbums < ActiveRecord::Migration[4.2]
  def change
    add_column :albums, :editions, :text
  end
end
