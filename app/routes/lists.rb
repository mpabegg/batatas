get '/lists/:id/?' do
  list = List[params[:id]]
  halt 404 unless list
  json list.to_json
end

get '/lists/?' do
  json List.all.map(&:to_json)
end

post '/lists/?' do
  params.merge!(JSON.parse(request.body.read))
  list = List.create(:name => params['name'])
  list.add(params['items']) if params['items']

  headers({'Location' => "/lists/#{list.id}"})
  status 201
  json list.to_json
end
