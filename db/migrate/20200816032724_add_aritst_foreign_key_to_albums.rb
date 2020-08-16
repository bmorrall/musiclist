class AddAritstForeignKeyToAlbums < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :albums, :artists
  end
end
