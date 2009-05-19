class ActsAsScribeMigration < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.integer :creator_id, :default => 0
      t.string  :creator_type, :limit => 50
      t.string  :action
      t.integer :item_id, :default => 0
      t.string  :item_type, :limit => 50
      t.timestamps
    end
    add_index :activities, :creator_id
  end

  def self.down
    drop_table :activities
  end

end