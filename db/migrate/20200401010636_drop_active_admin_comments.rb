class DropActiveAdminComments < ActiveRecord::Migration[6.0]
  def up
    drop_table :active_admin_comments
  end
end
