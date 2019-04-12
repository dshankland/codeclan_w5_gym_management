require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/gymclass.rb')
also_reload('../models/*')

get '/classes' do
  @gymclasses = GymClass.all()
  erb (:'gymclasses/index')
end

get '/classes/:id' do
  @gymclass = GymClass.find(params['id'].to_i)
  erb(:'gymclasses/show')
end