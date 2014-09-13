require 'spec_helper'

RSpec.shared_examples 'an item marked as bought' do
  it 'responds with created' do
    post "lists/#{list.id}/items/#{item.id}/bought"
    expect(last_response.status).to eq 201
  end

  it 'marks the item as bought' do
    post "lists/#{list.id}/items/#{item.id}/bought"
    expect(item.reload).to be_bought
  end

  it 'responds with the item' do
    expected_response = JSON.generate(item.to_json.merge(bought: true))

    post "lists/#{list.id}/items/#{item.id}/bought"

    expect(last_response.body).to eq expected_response
  end
end

describe Item do
  let(:options) { {'CONTENT_TYPE' => 'application/json'} }

  describe 'POST /lists/:list_id/items' do
    context 'when list does not exist' do
      it 'responds with not found' do
        post '/lists/blah/items/', '{}', options

        expect(last_response.status).to eq 404
      end

      it 'responds with empty body' do
        post '/lists/blah/items/', '{}', options

        expect(last_response.body).to eq ''
      end
    end

    context 'when list exists' do

      let(:list) { List.create(name: 'Cheesecake') }

      it 'responds with no content' do
        post "/lists/#{list.id}/items/", post_body, options
        expect(last_response.status).to eq 201
      end

      it 'responds with emtpy body' do
        post "/lists/#{list.id}/items/", post_body, options
        expect(last_response.body).to eq ''
      end

      it 'adds the item to the list' do
        cream_cheese = Product.create(name: 'Cream Cheese')
        lime = Product.create(name: 'Lime')

        post "/lists/#{list.id}/items/", post_body, options


        items = [
            Item.new(list: list, product: cream_cheese, amount: "1", bought: false),
            Item.new(list: list, product: lime, amount: "3", bought: false)
        ]
        expect(list.items).to be_like(items)
      end
    end
  end

  describe 'POST /lists/:list_id/items/:item_id/bought' do
    context 'when list does not exist' do
      it 'responds with not found' do
        post 'lists/no/items/meh/bought'
        expect(last_response.status).to eq 404
      end
    end

    context 'when list exists' do
      let(:list) { List.create(name: 'Cheesecake') }

      context 'and item does not exist' do
        it 'responds with not found' do
          post "lists/#{list.id}/items/meh/bought"
          expect(last_response.status).to eq 404
        end
      end


      context 'and item exists' do
        let(:item) { Item.new(product: Product.create(name: 'Banana'), amount: 3) }

        context 'when item is not in the list' do
          it 'responds with not found' do
            post "lists/#{list.id}/items/#{item.id}/bought"
            expect(last_response.status).to eq 404
          end
        end

        context 'when item is on the list' do
          before :each do
            list.add_item(item)
          end

          context 'and item is not yet bought' do
            before :each do
              item.bought = false
              item.save
            end

            it_behaves_like 'an item marked as bought'
          end

          context 'and item is already bought' do
            before :each do
              item.bought = true
              item.save
            end

            it_behaves_like 'an item marked as bought'
          end
        end
      end
    end
  end
end
private

def post_body
  JSON.generate([
                    {name: "Cream Cheese", amount: "1"},
                    {name: "Lime", amount: "3"}
                ])
end
