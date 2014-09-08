require 'rake'
require 'sequel'
require './server'

namespace :db do
  task :reset do
    Sequel::Migrator.run(database, 'database/migrations', :target => 0)
    Sequel::Migrator.run(database, 'database/migrations')
  end

  task :migrate do
    Sequel::Migrator.run(database, 'database/migrations')
  end
end