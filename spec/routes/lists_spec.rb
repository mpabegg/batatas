require 'spec_helper'


describe List do

  before :each do
    @potato = Product.create(name: 'potato')
    @tomato = Product.create(name: 'tomato')
  end

  describe 'GET' do
    let (:list) { List.create(name: 'A Shopping List') }
    describe '/lists' do
      it 'responds with success' do
        get '/lists'
        expect(last_response.status).to be 200
      end

      it 'responds with list of lists' do
        add_items_to_list

        get '/lists'
        expect(last_response.body).to be_a_json_like "[#{full_list_body}]"
      end
    end

    describe '/lists/:id' do
      context 'when list does not exist' do
        before(:each) { get '/lists/no_list' }
        it_behaves_like 'a request to an inexisting resource'
      end

      context 'when list exists' do
        it 'responds with success' do
          get "/lists/#{list.id}"

          expect(last_response.status).to be 200
        end

        context 'and is empty' do
          let(:empty_list) { '{"id": 1, "name" : "A Shopping List", "items": [] }' }
          it 'responds with list name and no items' do
            get "/lists/#{list.id}"

            expect(last_response.body).to be_a_json_like empty_list
          end
        end

        context 'and has items' do
          before :each do
            add_items_to_list
          end

          it 'responds with every item' do
            get "/lists/#{list.id}"

            expect(last_response.body).to be_a_json_like full_list_body
          end
        end
      end
    end
  end

  describe 'POST /lists' do

    let(:options) { {'CONTENT_TYPE' => 'application/json'} }

    it 'creates a list with name' do
      post '/lists', '{"name": "Lista!"}', options

      expect(List.first.name).to eq 'Lista!'
    end

    it 'has the list location on the response header' do
      post '/lists', '{"name": "Lista!"}', options

      expect(last_response.headers['Location']).to match /\/lists\/#{List.first.id}/
    end

    it 'adds items to the list' do
      post '/lists', full_list_body, options

      expect(List.first.items).to be_like([Item.new(product: @potato, amount: 3, list: List.first, bought: false),
                                           Item.new(product: @tomato, amount: 5, list: List.first, bought: true)])
    end

    it 'responds with the created list' do
      post '/lists', full_list_body, options
      expect(last_response.body).to be_a_json_like full_list_body
    end
  end

  describe 'DELETE /lists/:list_id' do
    context 'when the list does not exist' do
      before(:each) { delete '/lists/999' }
      it_behaves_like 'a request to an inexisting resource'
    end

    context 'when list exists' do
      let(:list) { List.create(name: 'A Shopping List') }

      it 'responds with success' do
        delete "/lists/#{list.id}"
        expect(last_response.status).to eq 200
      end

      it 'responds with empty body' do
        delete "/lists/#{list.id}"
        expect(last_response.body).to be_empty
      end

      it 'deletes the list' do
        expect(List[list.id].name).to eq list.name

        delete "/lists/#{list.id}"

        expect(List[list.id]).to be_nil
      end

      context 'and has items on it' do
        let(:batata) { Product.create(name: 'batata') }

        before(:each) { list.add_item(Item.new(product: batata, amount: 4)) }

        it 'destroy the items on the list' do
          batata_id = list.items.first.id
          expect(list.items.length).to eq 1
          delete "/lists/#{list.id}"

          expect(Item[batata_id]).to be_nil
        end
      end
    end
  end
end

private
def full_list_body
  '{
    "id": 1,
    "name": "A Shopping List",
    "items": [
      { "id": 1, "name": "potato", "amount": 3, "bought": false },
      { "id": 2, "name": "tomato", "amount": 5, "bought": true }
    ]
  }'
end

def add_items_to_list
  list.add_item(product: @potato, amount: 3)
  list.add_item(product: @tomato, amount: 5, bought: true)
  list.save
end

