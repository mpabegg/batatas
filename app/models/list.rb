class List < Sequel::Model
  Sequel::Model.plugin :json_serializer

  one_to_many :list_items
end