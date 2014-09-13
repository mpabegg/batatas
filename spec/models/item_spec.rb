require 'spec_helper'

describe Item do
  let(:list) { List.create(name: 'Lista') }
  let(:product) { Product.create(name: 'Batatas') }
  let(:subject) { Item.new(list: list, product: product, amount: 1, bought: false) }

  describe '#buy' do
    it 'marks the item as bought' do
      subject.buy
      expect(subject).to be_bought
    end
  end

  describe '#unbuy' do

    let(:subject) { Item.new(list: list, product: product, amount: 1, bought: true) }

    it 'marks the item as bought' do
      subject.unbuy
      expect(subject).not_to be_bought
    end
  end
end