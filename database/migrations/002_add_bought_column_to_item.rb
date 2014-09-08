require 'sinatra'
require 'sinatra/sequel'

Sequel.migration do
  up do
    add_column :items, :bought, :boolean, default: false
    from(:items).update(bought: false)
  end

  down do
    drop_column :items, :bought
  end
end