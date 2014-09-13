shared_examples 'a request to an inexisting resource' do
  it 'responds with not found' do
    expect(last_response.status).to eq 404
  end

  it 'responds with empty body' do
    expect(last_response.body).to eq ''
  end
end