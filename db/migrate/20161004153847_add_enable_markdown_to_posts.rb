class AddEnableMarkdownToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :enable_markdown, :boolean
  end
end
