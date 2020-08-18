class AddSlugToAlbums < ActiveRecord::Migration[6.0]
  def change
    add_column :albums, :slug, :string
  end
end
