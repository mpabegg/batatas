require 'spec_helper'

describe Product do
  before :each do
    Product.each(&:destroy)
  end

  describe 'GET /products/:id' do
    context 'when product does not exist' do
      it 'responds with not found' do
        get '/products/something'
        expect(last_response.status).to be 404
      end

      it 'responds with empty body' do
        get '/products/something'
        expect(last_response.body).to eq ''
      end
    end

    context 'when product exists' do
      let(:product) { Product.create(name: 'Batata') }

      it 'responds with success' do
        get "/products/#{product.id}/"

        expect(last_response.status).to be 200
      end
    end
  end

  describe 'POST /products' do
    let(:options) { {'CONTENT_TYPE' => 'application/json'} }

    it 'creates a product with name' do
      post '/products', '{"name": "Potato"}', options

      expect(Product.first.name).to eq 'Potato'
    end

    it 'has the list location on the response header' do
      post '/products', '{"name": "Tomato"}', options

      expect(last_response.headers['Location']).to match /\/products\/\d+/
    end
  end
end