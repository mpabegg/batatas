require 'spec_helper'

describe 'GET lists/:id' do
  it 'succeeds' do
    get 'lists/1'
    expect(last_response.status).to be 200
  end
end