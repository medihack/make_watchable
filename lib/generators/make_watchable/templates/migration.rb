class CreateMakeWatchableTables < ActiveRecord::Migration
   def self.up
     create_table :watchings do |t|
       t.string :watchable_type
       t.integer :watchable_id
       t.string :watcher_type
       t.integer :watcher_id

       t.timestamps
    end

    add_index :watchings, [:watchable_type, :watchable_id]
    add_index :watchings, [:watcher_type, :watcher_id, :watchable_type, :watchable_id], :name => "access_watchings"
  end

  def self.down
    remove_index :watchings, :column => [:watchable_type, :watchable_id]
    remove_index :watchings, :name => "access_watchings"
    
    drop_table :watchings
  end
end
