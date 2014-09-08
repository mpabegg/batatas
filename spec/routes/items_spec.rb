require 'spec_helper'

describe Item do
  describe 'POST /lists/:list_id/items' do
    let(:options) { {'CONTENT_TYPE' => 'application/json'} }

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
        post "/lists/#{list.id}/items/", '{}', options
        expect(last_response.status).to eq 201
      end

      it 'responds with emtpy body' do
        post "/lists/#{list.id}/items/", '{}', options
        expect(last_response.body).to eq ''
      end

      it 'adds the item to the list' do
        cream_cheese = Product.create(name: 'Cream Cheese')
        lime = Product.create(name: 'Lime')

        post "/lists/#{list.id}/items/", post_body, options


        items = [
            Item.new(list: list, product: cream_cheese, amount: 1, bought: false),
            Item.new(list: list, product: lime, amount: 3, bought: false)
        ]
        expect(list.items).to eq items
      end
    end
  end
end

private
def post_body
  '[
      {"name": "Cream Cheese", "amount": 1},
      {"name": "Lime", "amount": 3}
  ]'
end
