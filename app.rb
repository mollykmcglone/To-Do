require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/to_do')
require('./lib/list')
require('pg')

DB = PG.connect({:dbname => "to_do"})

get('/') do
  erb(:index)
end

get("/lists/new") do
  erb(:lists_form)
end

post("/lists") do
  name = params.fetch("list_name")
  @list = List.new({:name => name, :id => nil})
  @list.save()
  erb(:list_success)
end

get("/lists") do
  @lists= List.all()
  erb(:lists)
end
