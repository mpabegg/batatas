get '/products/:id/?' do
  product = Product[params[:id]]
  halt 404 unless product
  json product.to_json
end

get '/products/?' do
  json Product.all
end

post '/products/?' do
  params.merge!(JSON.parse(request.body.read))
  product = Product.create(:name => params['name'])
  headers({'Location' => "/products/#{product.id}"})
  status 201
end
