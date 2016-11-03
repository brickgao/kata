class AddExtraMessagesToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :extra_messages, :string
  end
end
