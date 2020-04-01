class CreateMetaData < ActiveRecord::Migration
  def change
    create_table :meta_data do |t|
      t.string :source
      t.text :data
      t.references :item, :polymorphic => true

      t.timestamps
    end
    add_index :meta_data, :item_id
  end
end
