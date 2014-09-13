require 'spec_helper'

describe List do
  let(:list_name) { 'List Name' }
  let(:april_1st) { Time.parse('2014-04-01') }

  let(:tomatoes) { Item.new(product: Product.create(name: 'Tomato'), amount: 2) }
  let(:potatoes) { Item.new(product: Product.create(name: 'Potato'), amount: 5) }

  let(:subject) { List.new(name: list_name) }

  before :each do
    Time.stub(:now).and_return(april_1st)
    subject.save

    subject.add_item(potatoes)
    subject.add_item(tomatoes)
  end

  it 'has a name' do
    expect(subject.name).to eq list_name
  end

  it 'has a creation time' do
    expect(subject.created_at).to eq april_1st
  end

  it 'has items on it' do
    expect(subject.items).to include tomatoes
    expect(subject.items).to include potatoes
  end

  it 'adds an array of items' do
    subject.add([{"amount" => 1, "bought" => false, "name" => "asdgsadg"}])

    expect(subject.items.length).to eq 3
  end

  it 'adds a single item' do
    subject.add({"amount" => 1, "bought" => false, "name" => "asdgsadg"})

    expect(subject.items.length).to eq 3
  end
end
