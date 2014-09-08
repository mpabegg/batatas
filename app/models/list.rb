class List < Sequel::Model
  one_to_many :items

  def add(items)
    items.each do |item|
      add_item(product: Product.with_name(item['name']), amount: item['amount'], bought: item['bought'])
    end
    save
  end

  def to_json
    {
        id: id,
        name: name,
        items: items.map(&:to_json)
    }
  end
end