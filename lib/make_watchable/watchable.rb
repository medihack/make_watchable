module MakeWatchable
  module Watchable
    extend ActiveSupport::Concern

    included do
      has_many :watchings, :class_name => "MakeWatchable::Watching", :as => :watchable
    end

    module ClassMethods
      def watchable?
        true
      end
    end

    def watched_by?(watcher)
      watcher.watches?(self)
    end
  end
end
