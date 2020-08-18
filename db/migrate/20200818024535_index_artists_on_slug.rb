class IndexArtistsOnSlug < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    add_index :artists, :slug, unique: true, algorithm: :concurrently
  end
end
