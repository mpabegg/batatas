class Item < Sequel::Model
  many_to_one :list
  many_to_one :product

  def to_json
    {
        name: product.name,
        amount: amount,
        bought: bought
    }
  end
end
