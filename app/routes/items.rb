post '/lists/:list_id/items/?' do
  body = request.body.read
  logger.info ("Request Body: #{body}")
  list = List[params[:list_id]]
  halt 404 unless list

  list.add(JSON.parse(body)) if body

  status 201
end