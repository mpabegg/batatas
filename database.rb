require 'sinatra'
require 'sinatra/sequel'

Sequel::Model.plugin :timestamps

migration 'create the lists table' do
  database.create_table :lists do
    primary_key :id
    String :name, null: false
    timestamp :created_at, null: false
  end
end

migration 'create the items table' do
  database.create_table :items do
    primary_key :id
    text :name, null: false
    foreign_key :list_id
  end
end

migration 'create the list_items table' do
  database.create_table :list_items do
    primary_key [:list_id, :item_id], name: 'list_item_pk'
    foreign_key :list_id, null: false
    foreign_key :item_id, null: false
    Fixnum :amount
  end
end
