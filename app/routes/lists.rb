get '/lists/:id/?' do
  list = List[params[:id]]
  halt 404 unless list
  json list.to_json
end

get '/lists/?' do
  json List.all.map(&:to_json)
end

post '/lists/?' do
  body = request.body.read
  logger.info ("Request Body: #{body}")
  params.merge!(JSON.parse(body))
  list = List.create(:name => params['name'])
  list.add(params['items']) if params['items']

  headers({'Location' => "/lists/#{list.id}"})
      status 201
  json list.to_json
end
