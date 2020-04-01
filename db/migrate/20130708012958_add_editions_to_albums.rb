class AddEditionsToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :editions, :text
  end
end
