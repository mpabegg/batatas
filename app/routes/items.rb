post '/lists/:list_id/items/?' do
  list = List[params[:list_id]]
  halt 404 unless list

  status 201
end