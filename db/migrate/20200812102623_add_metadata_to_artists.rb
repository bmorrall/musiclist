class AddMetadataToArtists < ActiveRecord::Migration[6.0]
  def change
    add_column :artists, :lastfm_url, :string
    add_column :artists, :profile_image, :string
    add_column :artists, :description, :text
  end
end
