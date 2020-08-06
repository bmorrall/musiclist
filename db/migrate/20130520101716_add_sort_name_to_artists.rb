class AddSortNameToArtists < ActiveRecord::Migration[4.2]
  def change
    add_column :artists, :sort_name, :string
  end
end
