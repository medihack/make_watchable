module MakeWatchable
  module Exceptions
    class AlreadyWatchingError < StandardError
      def initialize
        super "The watcher is already watching this watchable."
      end
    end

    class NotWatchingError < StandardError
      def initialize
        super "The watcher is not watching the watchable."
      end
    end

    class InvalidWatchableError < StandardError
      def initialize
        super "Invalid watchable."
      end
    end
  end
end
