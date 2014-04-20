class ListItem < Sequel::Model
  many_to_many :lists
  many_to_many :items
end