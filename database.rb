require 'sequel'
require 'sinatra'
require 'sinatra/sequel'

Sequel.extension :migration, :core_extensions
Sequel::Model.plugin :timestamps

Sequel::Migrator.run(database, 'database/migrations')