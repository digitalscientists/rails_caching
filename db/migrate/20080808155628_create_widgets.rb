class CreateWidgets < ActiveRecord::Migration
  def self.up
    create_table :widgets do |t|
      t.string :name
      t.text :description
      t.boolean :active

      t.timestamps
    end
    add_index :widgets, :name
    add_index :widgets, :active
  end

  def self.down
    drop_table :widgets
  end
end
