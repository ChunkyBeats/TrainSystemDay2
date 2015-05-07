require('sinatra')
require('sinatra/reloader')
also_reload('./lib/*.rb')
require('./lib/city')
require('./lib/train')
require('pg')

DB = PG.connect({:dbname => "train_system"})

get('/') do
  erb(:index)
end

get('/system_operator') do
  @all_cities = City.all
  @all_trains = Train.all
  erb(:system_operator)
end

get('/system_operator/add_city') do
  erb(:add_city)
end

post('/system_operator/add_city') do
  city_name = params.fetch('city_name')
  city = City.new(name: city_name)
  city.save()
  @all_cities = City.all()
  @all_trains = Train.all
  erb(:system_operator)
end

get('/system_operator/add_train') do
  erb(:add_train)
end

post('/system_operator/add_train') do
  train_name = params.fetch('train_name')
  train = Train.new(name: train_name)
  train.save
  @all_trains = Train.all
  @all_cities = City.all
  erb(:system_operator)
end


get('rider') do
  erb(:rider)
end
