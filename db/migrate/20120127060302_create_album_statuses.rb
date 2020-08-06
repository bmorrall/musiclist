class CreateAlbumStatuses < ActiveRecord::Migration[4.2]
  def change
    create_table :album_statuses do |t|
      t.integer :album_id
      t.boolean :played
      t.boolean :purchased

      t.timestamps
    end
  end
end
