class Item < Sequel::Model
  many_to_one :list
  many_to_one :product
end
