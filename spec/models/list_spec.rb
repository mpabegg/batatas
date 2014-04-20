require 'spec_helper'

describe List do
  let(:list_name) { 'List Name' }
  let(:april_1st) { Time.parse('2014-04-01') }

  let(:tomatoes) { ListItem.new(item: Item.create(name: 'Tomato'), amount: 2) }
  let(:potatoes) { ListItem.new(item: Item.create(name: 'Potato'), amount: 5) }

  let(:subject) { List.new(name: list_name) }

  before :each do
    Time.stub(:now).and_return(april_1st)
    subject.save

    subject.add_list_item(potatoes)
    subject.add_list_item(tomatoes)
  end

  it 'has a name' do
    expect(subject.name).to eq list_name
  end

  it 'has a creation time' do
    expect(subject.created_at).to eq april_1st
  end

  it 'has items on it' do
    expect(subject.list_items).to include tomatoes
    expect(subject.list_items).to include potatoes
  end
end