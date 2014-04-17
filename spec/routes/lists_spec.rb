require 'spec_helper'

describe 'GET lists/:id' do

  context 'when list exists' do
    let(:the_list) { List.new }
    let(:list_to_json) { '{}' }
    let(:list_id) { '1' }

    before :each do
      List.stub(:[]).with(list_id).and_return(the_list)
      the_list.stub(:to_json).and_return(list_to_json)
    end

    it 'responds with success' do
      get "/lists/#{list_id}"
      expect(last_response.status).to be 200
    end

    it 'renders the list JSON' do
      expect(the_list).to receive(:to_json)

      get "/lists/#{list_id}"

      expect(last_response.body).to eq list_to_json
    end
  end

  context 'when list does not exist' do
    before :each do 
      List.stub(:[]).and_return(nil)
    end

    it 'responds with not found' do
      get "/lists/some"
      expect(last_response.status).to be 404
    end

    it 'responds with an empty body' do
      get "/lists/some"
      # expect(last_response.body).to be_empty
      expect(last_response.body).to eq ''
    end
  end
end