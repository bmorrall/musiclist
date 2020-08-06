class AddGenreAlbumArtAndYearToAlbums < ActiveRecord::Migration[4.2]
  def change
    add_column :albums, :genre, :string
    add_column :albums, :album_art, :string
    add_column :albums, :year, :string
  end
end
