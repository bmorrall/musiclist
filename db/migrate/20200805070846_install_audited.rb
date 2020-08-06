# frozen_string_literal: true

class InstallAudited < ActiveRecord::Migration[6.0]
  def self.up
    create_table :audits, force: true do |t|
      t.column :auditable_id, :integer
      t.column :auditable_type, :string
      t.column :associated_id, :integer
      t.column :associated_type, :string
      t.column :user_uid, :string
      t.column :user_id, :uuid
      t.column :user_type, :string
      t.column :username, :string
      t.column :action, :string
      t.column :audited_changes, :jsonb
      t.column :version, :integer, default: 0
      t.column :comment, :string
      t.column :remote_address, :string
      t.column :request_uuid, :string
      t.column :created_at, :datetime

      t.index %i[auditable_type auditable_id version], name: "auditable_index"
      t.index %i[associated_type associated_id], name: "associated_index"
      t.index %i[user_type user_id], name: "user_index"
      t.index :user_uid, name: "user_uid_index"
      t.index :request_uuid
      t.index :created_at
    end
  end

  def self.down
    drop_table :audits
  end
end
