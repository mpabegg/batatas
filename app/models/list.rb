class List < Sequel::Model
  one_to_many :items

  def to_json
    {
        name: name,
        items: items.map(&:to_json)
    }
  end
end