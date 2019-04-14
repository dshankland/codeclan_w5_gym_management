require('sinatra')
require('sinatra/contrib/all')
require_relative('controllers/gymclasses_controller')
require_relative('controllers/members_controller')
require_relative('controllers/bookings_controller')

helpers do
  def active_page?(path='')
    request.path_info == '/' + path
  end
end

get '/' do
  # erb(:index)
  redirect to ('/classes')
end