require_relative('../models/member.rb')
require_relative('../models/gymclass.rb')
require_relative('../models/booking.rb')
require('time')
require('pry-byebug')

Booking.delete_all()
Member.delete_all()
GymClass.delete_all()

member1 = Member.new({'name' => 'Darren Shankland', 'premium' => false})
member1.save()
member2 = Member.new({'name' => 'Ann Campbell', 'premium' => true})
member2.save()
member3 = Member.new({'name' => 'Arnold Schwarzenneger', 'premium' => true})
member3.save()


time1 = Time.parse('2019-04-12 17:00 +0100')
gymclass1 = GymClass.new({'name' => 'Body Combat', 'time' => time1, 'spaces' => 20})
gymclass1.save()
time2 = Time.parse('2019-04-13 09:00 +0100')
gymclass2 = GymClass.new({'name' => 'Yoga', 'time' => time2, 'spaces' => 10})
gymclass2.save()
time3 = Time.parse('2019-04-14 10:00 +0100')
gymclass3 = GymClass.new({'name' => 'Weights', 'time' => time3, 'spaces' => 15})
gymclass3.save()


booking1 = Booking.new({'member_id' => member1.id, 'gymclass_id' => gymclass1.id})
booking1.save()
booking2 = Booking.new({'member_id' => member2.id, 'gymclass_id' => gymclass2.id})
booking2.save()
booking3 = Booking.new({'member_id' => member3.id, 'gymclass_id' => gymclass3.id})
booking3.save()


binding.pry

nil