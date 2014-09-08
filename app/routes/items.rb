post '/lists/:list_id/items/?' do
  list = List[params[:list_id]]
  halt 404 unless list

  body = JSON.parse(request.body.read)
  list.add(body) if body

  status 201
end