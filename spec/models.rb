class WatchableModel < ActiveRecord::Base
  make_watchable
end

class WatcherModel < ActiveRecord::Base
  make_watcher
end

class InvalidWatchableModel < ActiveRecord::Base
end
