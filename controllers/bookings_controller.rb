require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/gymclass.rb')
require_relative('../models/member.rb')
require_relative('../models/booking.rb')
also_reload('../models/*')

post '/bookings' do
  booking = Booking.new(params)
  booking.save
  redirect to("/classes/#{params['gymclass_id']}")
end