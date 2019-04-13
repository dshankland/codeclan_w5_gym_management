require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/gymclass.rb')
require_relative('../models/member.rb')
require_relative('../models/booking.rb')
also_reload('../models/*')
require('pry-byebug')

post '/bookings' do
  booking = Booking.new(params)
  booking.save
  redirect to("/classes/#{params['gymclass_id']}")
end

post '/bookings/:id/delete' do
  booking = Booking.find(params[:id])
  booking.delete()
  redirect back
end