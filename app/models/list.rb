class List < Sequel::Model
  one_to_many :items

  def add(items)
    items = [items].flatten
    items.each { |item| add_item(from_json(item)) }
    save
  end


  def to_json
    {
        id: id,
        name: name,
        items: items.map(&:to_json)
    }
  end

  def item(id)
    items.find { |i| i.id == id}
  end

  private
  def from_json(item)
    options = {product: Product.with_name(item['name']), amount: item['amount']}
    options[:bought] = item['bought'] if item['bought']
    options
  end
end