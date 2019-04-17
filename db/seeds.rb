require_relative('../models/member.rb')
require_relative('../models/gymclass.rb')
require_relative('../models/booking.rb')
require('time')
require('pry-byebug')

Booking.delete_all()
Member.delete_all()
GymClass.delete_all()

membership_type = [true, false]
member_first_names = ['John', 'Kevin', 'Lindsey', 'Mhairi', 'Paul', 'Sri', 'Theo', 'Anne', 'Atyha', 'Scott', 'David', 'Calum', 'Danny', 'Hugh', 'Darren', 'Stelios', 'Arnold', 'Sandy', 'Joe', 'Bob', 'Andy', 'Michael']
member_second_names = ['Shankland', 'Campbell', 'Schwarzenegger', 'Murray', 'Moir', 'Izzard', "O’Hagan", 'McCrindle', 'Flannery', 'Wright', 'McKendry', 'Maitland', 'Constantinou', 'Cannon', 'Arshad', 'Dara', 'Jarvis', 'Welsh']
gymclass_names = ['Body Combat', 'Yoga', 'Weights', 'Spin', 'Pump', 'Bootcamp', 'Kettlebells', 'Circuits', 'Abs', 'Legs,Bums,Tums']
gymclass_sizes = [5,10,15]

# create 20 sample members
for i in 1..20
  member_name = "#{member_first_names.sample()} #{member_second_names.sample()}"
  member1 = Member.new({'name' => member_name, 'premium' => membership_type.sample()})
  member1.save()
end

# Every day at 07:00 setup Bootcamp
starttime7 = Time.parse('07:00', Time.now())
for i in 0..6 do
  newtime = starttime7 + (60*60*24*i)
  gymclass1 = GymClass.new({'name' => gymclass_names[5], 'time' => newtime, 'spaces' => 10})
  gymclass1.save()
end

# Every day at 19:00
starttime18 = starttime7 + (60*60*11)
for i in 0..6 do
  newtime = starttime18 + (60*60*24*i)
  gymclass1 = GymClass.new({'name' => gymclass_names[7], 'time' => newtime, 'spaces' => 10})
  gymclass1.save()
end

# generate hour timeslots for the next 7 days from 8 - 10pm
hour = 60*60
starttime8 = starttime7 + hour
time_array = [starttime8]
for i in 0..6
  starttime = starttime8 + (60*60*24*i)
  time_array.push(starttime)
  for i in 1..14
    time_array.push(starttime + (hour*i))
  end
end

# generate 50 random classes throughout the next 7 days
for i in 1..50
  gymclass1 = GymClass.new({'name' => gymclass_names.sample(), 'time' => time_array.sample(), 'spaces' => gymclass_sizes.sample()})
  gymclass1.save()
end

# create 100 random class bookings over the classes
for i in 1..100
  gymclass = GymClass.all().sample()
  params = {'member_id' => gymclass.available_members().sample().id, 'gymclass_id' => gymclass.id}
  booking = Booking.new(params)
  booking.save()
  gymclass.decrease_spaces()
  gymclass.update()
end

binding.pry

nil