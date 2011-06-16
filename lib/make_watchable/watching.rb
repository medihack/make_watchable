module MakeWatchable
  class Watching < ActiveRecord::Base
    belongs_to :watchable, :polymorphic => true
    belongs_to :watcher, :polymorphic => true
  end
end
