require 'spec_helper'

describe Product do


  describe 'GET /products/:id' do
    let(:batata) { Product.create(name: 'Batata') }
    context 'when product does not exist' do
      before(:each) {get '/products/something'}
      it_behaves_like 'a request to an inexisting resource'
    end

    context 'when product exists' do

      it 'responds with success' do
        get "/products/#{batata.id}/"

        expect(last_response.status).to be 200
      end

      it 'responds with the product' do
        get "/products/#{batata.id}/"

        expect(last_response.body).to eq JSON.generate(batata.to_json)
      end
    end
  end

  describe 'POST /products' do
    let(:options) { {'CONTENT_TYPE' => 'application/json'} }
    let(:batata) { Product.new(name: 'Batata')}

    it 'creates a product with name' do
      post '/products', JSON.generate(batata.to_json), options

      expect(Product.first.name).to eq batata.name
    end

    it 'has the list location on the response header' do
      post '/products', JSON.generate(batata.to_json), options

      expect(last_response.headers['Location']).to match /\/products\/\d+/
    end
  end
end