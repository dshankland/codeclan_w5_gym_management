require('sinatra')
require('sinatra/contrib/all') if development?
require_relative('../models/gymclass.rb')
require_relative('../models/member.rb')
require_relative('../models/booking.rb')
# also_reload('../models/*')
# require('pry-byebug')

post '/bookings' do
  booking = Booking.new(params)
  booking.save
  gymclass = GymClass.find(params['gymclass_id'])
  gymclass.decrease_spaces()
  gymclass.update()
  # redirect to("/classes/#{params['gymclass_id']}")
  redirect to("/classes/#{params['gymclass_id']}/edit")
end

post '/bookings/:id/delete' do
  booking = Booking.find(params[:id])
  booking.delete()
  gymclass = GymClass.find(params['gymclass_id'])
  gymclass.increase_spaces()
  gymclass.update()
  # redirect to("/classes/#{params['gymclass_id']}")
  redirect to("/classes/#{params['gymclass_id']}/edit")
  # redirect back
end