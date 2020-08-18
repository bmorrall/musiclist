class AddSlugToArtists < ActiveRecord::Migration[6.0]
  def change
    add_column :artists, :slug, :string
  end
end
