get '/products/:id/?' do
  product = Product[params[:id]]
  halt 404 unless product
  json product.to_json
end

get '/products/?' do
  json Product.all
end

post '/products/?' do
  body = request.body.read
  logger.info ("Request Body: #{body}")
  params.merge!(JSON.parse(body))
  product = Product.create(name: params['name'])
  headers({'Location' => "/products/#{product.id}"})
  status 201
end