ActiveRecord::Schema.define :version => 0 do
  create_table :watchable_models, :force => true do |t|
    t.string :name
  end

  create_table :watcher_models, :force => true do |t|
    t.string :name
  end

  create_table :invalid_watchable_models, :force => true do |t|
    t.string :name
  end

  create_table :watchings, :force => true do |t|
     t.string :watchable_type
     t.integer :watchable_id
     t.string :watcher_type
     t.integer :watcher_id

     t.timestamps
  end

  add_index :watchings, [:watchable_type, :watchable_id]
  add_index :watchings, [:watcher_type, :watcher_id, :watchable_type, :watchable_id], :name => "access_watchings"
end
