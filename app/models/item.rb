class Item < Sequel::Model
	Sequel::Model.plugin :json_serializer
	many_to_one :list
end