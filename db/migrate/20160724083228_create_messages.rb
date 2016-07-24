class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :body
      t.references :from, index: true, foreign_key: true
      t.references :to, index: true, foreign_key: true
      t.integer :is_read

      t.timestamps null: false
    end
  end
end
