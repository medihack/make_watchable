require 'spec_helper'
require 'action_controller'
require 'generator_spec/test_case'
require 'generators/make_watchable/make_watchable_generator'

describe MakeWatchableGenerator do
  include GeneratorSpec::TestCase
  destination File.expand_path("/tmp", __FILE__)
  tests MakeWatchableGenerator

  before do
    prepare_destination
    run_generator
  end

  specify do
    destination_root.should have_structure {
      directory "db" do
        directory "migrate" do
          migration "create_make_watchable_tables" do
            contains "class CreateMakeWatchableTables"
            contains "create_table :watchings"
          end
        end
      end
    }
  end
end
