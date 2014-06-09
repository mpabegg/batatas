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

migration 'create the products table' do
  database.create_table :products do
    primary_key :id
    text :name, null: false
    timestamp :created_at, null: false
  end
end

migration 'create the items table' do
  database.create_table :items do
    primary_key [:list_id, :product_id], name: 'item_pk'
    foreign_key :list_id, null: false
    foreign_key :product_id, null: false
    Fixnum :amount
  end
end
