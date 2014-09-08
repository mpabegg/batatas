require 'sinatra'
require 'sinatra/sequel'

Sequel.migration do
  up do
    create_table :lists do
      primary_key :id
      String :name, null: false
      timestamp :created_at, null: false
    end

    create_table :products do
      primary_key :id
      text :name, null: false
      timestamp :created_at, null: false
    end

    create_table :items do
      primary_key [:list_id, :product_id], name: 'item_pk'
      foreign_key :list_id, null: false
      foreign_key :product_id, null: false
      Fixnum :amount
    end
  end

  down do
    drop_table :lists
    drop_table :products
    drop_table :items
  end
end