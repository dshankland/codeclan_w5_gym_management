require_relative('../models/member.rb')
require_relative('../models/gymclass.rb')
require_relative('../models/booking.rb')
require('time')
require('pry-byebug')

Booking.delete_all()
Member.delete_all()
GymClass.delete_all()

membership_type = [true, false]
member_names = ['Darren Shankland', 'Ann Campbell', 'Arnold Schwarzenegger', 'Fishy Bob', 'Sandy Beach', 'Billy Joe', 'Joey Bob', 'Bobby Joe']
for member_name in member_names
  member1 = Member.new({'name' => member_name, 'premium' => membership_type.sample()})
  member1.save()
end

gymclass_names = ['Body Combat', 'Yoga', 'Weights', 'Spin', 'Pump', 'Bootcamp', 'Kettlebells', 'Circuits']

# Every day at 07:00
starttime7 = Time.parse('07:00', Time.now())
for i in 0..6 do
  newtime = starttime7 + (60*60*24*i)
  gymclass1 = GymClass.new({'name' => gymclass_names[4], 'time' => newtime, 'spaces' => 10})
  gymclass1.save()
end

# Every day at 10:00
starttime10 = starttime7 + (60*60*3)
for i in 0..6 do
  newtime = starttime10 + (60*60*24*i)
  gymclass1 = GymClass.new({'name' => gymclass_names.sample(), 'time' => newtime, 'spaces' => 10})
  gymclass1.save()
end

# Every day at 13:00
starttime13 = starttime10 + (60*60*3)
for i in 0..6 do
  newtime = starttime13 + (60*60*24*i)
  gymclass1 = GymClass.new({'name' => gymclass_names.sample(), 'time' => newtime, 'spaces' => 10})
  gymclass1.save()
end

# Every day at 17:00
starttime17 = starttime13 + (60*60*2)
for i in 0..6 do
  newtime = starttime17 + (60*60*24*i)
  gymclass1 = GymClass.new({'name' => gymclass_names.sample(), 'time' => newtime, 'spaces' => 10})
  gymclass1.save()
end

# Every day at 19:00
starttime19 = starttime17 + (60*60*2)
for i in 0..6 do
  newtime = starttime19 + (60*60*24*i)
  gymclass1 = GymClass.new({'name' => gymclass_names.sample(), 'time' => newtime, 'spaces' => 10})
  gymclass1.save()
end

binding.pry

nil