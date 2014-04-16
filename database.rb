require 'sinatra'
require 'sinatra/sequel'

migration 'create the lists table' do
  database.create_table :lists do
    primary_key :id
    text        :name, :null => false
    timestamp   :create_at
  end
end

migration 'create the items table' do
  database.create_table :items do
    primary_key :id
    text        :name, :null => false
    foreign_key :list_id, :lists => :id
  end
end
