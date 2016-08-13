class AddSummaryToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :summary, :string
  end
end
