class RemoveSortNameFromArtists < ActiveRecord::Migration[6.0]
  def change
    remove_column :artists, :sort_name, :string, limit: 255
  end
end
