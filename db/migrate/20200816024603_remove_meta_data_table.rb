class RemoveMetaDataTable < ActiveRecord::Migration[6.0]
  def up
    drop_table :meta_data
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
