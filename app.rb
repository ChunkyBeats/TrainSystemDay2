require('sinatra')
require('sinatra/reloader')
also_reload('./lib/*.rb')
require('./lib/city')
require('./lib/train')
require('pg')

get('/') do
  erb(:index)
end

get('/system_operator') do
  erb(:system_operator)
end
