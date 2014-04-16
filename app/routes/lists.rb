get '/lists/:id' do
	json List[params[:id]]
end

get '/lists/?' do
	json List.all
end