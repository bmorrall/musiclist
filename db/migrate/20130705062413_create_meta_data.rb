class CreateMetaData < ActiveRecord::Migration[4.2]
  def change
    create_table :meta_data do |t|
      t.string :source
      t.text :data
      t.references :item, :polymorphic => true

      t.timestamps
    end
    safety_assured do
      add_index :meta_data, :item_id
    end
  end
end
