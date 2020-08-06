class AddLastfmUrlToAlbums < ActiveRecord::Migration[6.0]
  def change
    add_column :albums, :lastfm_url, :string
  end
end
