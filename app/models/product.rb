class Product < Sequel::Model
  Sequel::Model.plugin :json_serializer

  def to_json
    {
        name: name
    }
  end
end