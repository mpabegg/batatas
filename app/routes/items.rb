post '/lists/:list_id/items/?' do
  body = request.body.read
  logger.info ("Request Body: #{body}")
  list = List[params[:list_id]]
  halt 404 unless list

  list.add(JSON.parse(body)) if body

  status 201
end

delete '/lists/:list_id/items/:item_id/?' do
  list = List[params[:list_id]]
  halt 404 unless list

  item = list.item params[:item_id].to_i
  halt 404 unless item
end

post '/lists/:list_id/items/:item_id/bought/?' do
  list = List[params[:list_id]]
  halt 404 unless list

  item = list.item params[:item_id].to_i
  halt 404 unless item

  item.buy

  status 201
  json item.to_json
end

delete '/lists/:list_id/items/:item_id/bought/?' do
  list = List[params[:list_id]]
  halt 404 unless list

  item = list.item params[:item_id].to_i
  halt 404 unless item

  item.unbuy

  json item.to_json
end