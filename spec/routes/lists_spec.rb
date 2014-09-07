require 'spec_helper'


def add_items_to_list
  list.add_item(product: potato, amount: 3)
  list.add_item(product: tomato, amount: 5)
  list.save
end

describe List do
  let(:potato) { Product.create(name: 'Potato') }
  let(:tomato) { Product.create(name: 'tomato') }
  let (:list) { List.create(name: 'A Shopping List') }

  before :each do
    List.each(&:destroy)
  end

  describe 'GET /lists' do

    it 'responds with success' do
      get '/lists'
      expect(last_response.status).to be 200
    end

    it 'responds with list of lists' do
      add_items_to_list

      get '/lists'
      expect(JSON.parse(last_response.body)).to eq JSON.parse("[#{full_list_body}]")
    end
  end

  describe 'GET /lists/:id' do
    context 'when list does not exist' do
      it 'responds with not found' do
        get '/lists/no_list'
        expect(last_response.status).to be 404
      end

      it 'responds with empty body' do
        get '/lists/no_list'
        expect(last_response.body).to eq ''
      end
    end

    context 'when list exists' do


      it 'responds with success' do
        get "/lists/#{list.id}"

        expect(last_response.status).to be 200
      end

      context 'and is empty' do
        it 'responds with list name and no items' do
          get "/lists/#{list.id}"

          expect(JSON.parse(last_response.body)).to eq JSON.parse('{ "name" : "A Shopping List", "items": [] }')
        end
      end

      context 'and has items' do
        before :each do
          add_items_to_list
        end

        it 'responds with every item' do
          get "/lists/#{list.id}"


          expect(JSON.parse(last_response.body)).to eq JSON.parse(full_list_body)
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

      expect(last_response.headers['Location']).to match /\/lists\/\d+/
    end
  end
end

private
def full_list_body
  '{
    "name": "A Shopping List",
    "items": [
      { "name": "Potato", "amount": 3 },
      { "name": "tomato", "amount": 5 }
    ]
  }'
end
