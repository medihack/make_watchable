require 'rails/generators/migration'
require 'rails/generators/active_record'

class MakeWatchableGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  desc "Generates a migration for the watching model"

  def self.source_root
    @source_root ||= File.dirname(__FILE__) + '/templates'
  end

  def self.next_migration_number(path)
    ActiveRecord::Generators::Base.next_migration_number(path)
  end

  def generate_migration
    migration_template 'migration.rb', 'db/migrate/create_make_watchable_tables'
  end
end
