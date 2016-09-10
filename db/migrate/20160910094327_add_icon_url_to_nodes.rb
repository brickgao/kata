class AddIconUrlToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :icon_url, :string
  end
end
