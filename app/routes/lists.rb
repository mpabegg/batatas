get '/lists/:id/?' do
  list = List[params[:id]]
  halt 404 unless list
  json list
end

get '/lists/?' do
  json List.all
end

post '/lists/?' do
  List.create(:name => '')
  status 201
end
