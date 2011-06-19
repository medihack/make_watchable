require File.expand_path('../../spec_helper', __FILE__)

describe "Make Watchable" do
  before(:each) do
    @watchable = WatchableModel.create(:name => "Watchable 1")
    @watcher = WatcherModel.create(:name => "Watcher 1")
  end

  it "should create a watchable instance" do
    @watchable.class.should == WatchableModel
    @watchable.class.watchable?.should == true
  end

  it "should create a watcher instance" do
    @watcher.class.should == WatcherModel
    @watcher.class.watcher?.should == true
  end

  it "should have watchings" do
    @watcher.watchings.length.should == 0
    @watcher.watch!(@watchable)
    @watcher.watchings.reload.length.should == 1
  end

  describe "watcher" do
    describe "watch" do
      it "should create a watching" do
        @watchable.watchings.length.should == 0
        @watcher.watch!(@watchable).should == true
        @watchable.watchings.reload.length.should == 1
      end

      it "should only allow to watch a watchable per watcher once with rasing an error" do
        @watcher.watch!(@watchable)
        lambda { @watcher.watch!(@watchable) }.should raise_error(MakeWatchable::Exceptions::AlreadyWatchingError)
        @watchable.watchings.count.should == 1
      end

      it "should only allow to watch a watchable per watcher once without rasing an error" do
        @watcher.watch(@watchable)
        lambda {
          @watcher.flag(@watchable).should == false
        }.should_not raise_error(MakeWatchable::Exceptions::AlreadyWatchingError)
        @watchable.watchings.count.should == 1
      end
    end

    describe "unwatch" do
      it "should remove a watching" do
        @watcher.watch!(@watchable)
        @watcher.watchings.length.should == 1
        @watcher.unwatch!(@watchable).should == true
        @watcher.watchings.reload.length.should == 0
      end

      it "normal method should return true when successfully unflagged" do
        @watcher.watch(@watchable)
        @watcher.unwatch(@watchable).should == true
      end

      it "should raise error if watcher not watching the watchable with bang method" do
        lambda { @watcher.unwatch!(@watchable) }.should raise_error(MakeWatchable::Exceptions::NotWatchingError)
      end

      it "should not raise error if watcher not watching the watchable with normal method" do
        lambda {
          @watcher.unwatch(@watchable).should == false
        }.should_not raise_error(MakeWatchable::Exceptions::NotWatchingError)
      end
    end

    describe "watches?" do
      it "should check if watcher is watches the watchable" do
        @watcher.watches?(@watchable).should == false
        @watcher.watch!(@watchable)
        @watcher.watches?(@watchable).should == true
        @watcher.unwatch!(@watchable)
        @watcher.watches?(@watchable).should == false
      end
    end
  end

  describe "watchable" do
    it "should have watchings" do
      @watchable.watchings.length.should == 0
      @watcher.watch!(@watchable)
      @watchable.watchings.reload.length.should == 1
    end

    it "should check if watchable is watched by watcher" do
      @watchable.watched_by?(@watcher).should == false
      @watcher.watch!(@watchable)
      @watchable.watched_by?(@watcher).should == true
      @watcher.unwatch!(@watchable)
      @watchable.watched_by?(@watcher).should == false
    end
  end
end
