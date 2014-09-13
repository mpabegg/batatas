require 'sinatra'
require 'sinatra/sequel'

Sequel.migration do
  up do
    alter_table :items do
      drop_constraint 'item_pk', :type => :primary_key
      add_unique_constraint [:list_id, :product_id], :name => :unique_item_in_list
      add_primary_key :id
    end
  end

  down do
    alter_table :items do
      drop_constraint :id, :type => :primary_key
      add_primary_key [:list_id, :product_id], name: 'item_pk'
      drop_constraint :unique_item_in_list, :type => :unique
    end
  end
end