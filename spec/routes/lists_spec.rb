require 'spec_helper'

describe 'GET lists/:id' do

   context 'when list exists' do
      before :each do
         List.stub(:[]).with('1').and_return(List.new)
         get '/lists/1'
      end

      it 'responds with success' do
         expect(last_response.status).to be 200
      end

      it 'renders the list JSON' do
         expect(last_response.body).to eq '{}'   
      end
   end
end