class Product < Sequel::Model
  Sequel::Model.plugin :json_serializer

  def self.with_name name
    self.first(name: name) || create(name: name)
  end

  def to_json
    {
        name: name
    }
  end
end