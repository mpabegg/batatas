class List < Sequel::Model
  one_to_many :items

  def add(items)
    items.each do |item|
      add_item(product: Product.with_name(item['name']), amount: item['amount'])
    end
    save
  end

  def to_json
    {
        name: name,
        items: items.map(&:to_json)
    }
  end
end