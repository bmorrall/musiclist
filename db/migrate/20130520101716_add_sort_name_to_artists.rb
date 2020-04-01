class AddSortNameToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :sort_name, :string
  end
end
