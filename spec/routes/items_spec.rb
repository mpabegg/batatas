require 'spec_helper'

describe Item do

  before :each do
    List.each(&:destroy)
    Product.each(&:destroy)
  end

  describe 'POST /lists/:list_id/items' do
    context 'when list does not exist' do
      it 'responds with not found' do
        post '/lists/blah/items/', {}, {'CONTENT_TYPE' => 'application/json'}

        expect(last_response.status).to be 404
      end

      it 'responds with empty body' do
        post '/lists/blah/items/', {}, {'CONTENT_TYPE' => 'application/json'}

        expect(last_response.body).to eq ''
      end
    end

    context 'when list exists' do
      let(:list) { List.create(name: 'Cheesecake') }

      context 'and body is empty' do
        xit 'responds with unprocessable entity' do

        end
      end

      it 'responds with no content' do
        post "/lists/#{list.id}/items/", {}, {'CONTENT_TYPE' => 'application/json'}

        expect(last_response.status).to be 201
      end
    end
  end
end