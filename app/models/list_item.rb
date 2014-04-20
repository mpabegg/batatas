class ListItem < Sequel::Model
  many_to_one :list
  many_to_one :item
end