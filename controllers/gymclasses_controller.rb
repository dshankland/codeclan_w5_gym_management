require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/gymclass.rb')
also_reload('../models/*')

get '/classes' do
  @gymclasses = GymClass.all()
  erb (:'gymclasses/index')
end

get '/classes/new' do # new
  erb(:'gymclasses/new')
end

get '/classes/:id' do
  @gymclass = GymClass.find(params['id'].to_i)
  erb(:'gymclasses/show')
end

post '/classes' do # create
  @class = GymClass.new(params)
  @class.save()
  redirect to '/classes'
end

post '/classes/:id/delete' do
  gymclass = GymClass.find(params[:id])
  gymclass.delete()
  redirect to '/classes'
end

get '/classes/:id/edit' do
  @gymclass = GymClass.find(params['id'])
  erb(:'/gymclasses/edit')
end

post '/classes/:id' do
  gymclass = GymClass.new(params)
  gymclass.update
  redirect to "/classes/#{params['id']}"
end