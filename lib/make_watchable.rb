require 'make_watchable/watching'
require 'make_watchable/watchable'
require 'make_watchable/watcher'
require 'make_watchable/exceptions'

module MakeWatchable
  def watchable?
    false
  end

  def watcher?
    false
  end

  # Specify a model as watchable.
  #
  # Example:
  # class Repository < ActiveRecord::Base
  #   make_watchable
  # end
  def make_watchable
    include Watchable
  end

  # Specify a model as watcher.
  #
  # Example:
  # class User < ActiveRecord::Base
  #   make_watcher
  # end
  def make_watcher(options = {})
    include Watcher
  end
end

ActiveRecord::Base.extend MakeWatchable
