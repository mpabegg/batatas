require 'spec_helper'

describe List do

  before :each do
    List.each(&:destroy)
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
      let(:list) { List.create(name: 'A Shopping List') }

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

        let(:potato) { Product.create(name: 'Potato') }
        let(:tomato) { Product.create(name: 'tomato') }

        before :each do
          list.add_item(product: potato, amount: 3)
          list.add_item(product: tomato, amount: 5)
          list.save
        end

        it 'responds with every item' do
          get "/lists/#{list.id}"

          expected_body = '{
          "name": "A Shopping List",
          "items": [
            { "name": "Potato", "amount": 3 },
            { "name": "tomato", "amount": 5 }
          ]
        }'
          expect(JSON.parse(last_response.body)).to eq JSON.parse(expected_body)
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