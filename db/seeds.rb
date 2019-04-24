require_relative('../models/member.rb')
require_relative('../models/gymclass.rb')
require_relative('../models/booking.rb')
require('time')
# require('pry-byebug')

Booking.delete_all()
Member.delete_all()
GymClass.delete_all()

membership_type = [true, false]
member_first_names = ['John', 'Kevin', 'Lindsey', 'Mhairi', 'Paul', 'Sri', 'Theo', 'Anne', 'Atyha', 'Scott', 'David', 'Calum', 'Danny', 'Hugh', 'Darren', 'Stelios', 'Arnold', 'Sandy', 'Joe', 'Bob', 'Andy', 'Michael']
member_second_names = ['Shankland', 'Campbell', 'Schwarzenegger', 'Murray', 'Moir', 'Izzard', "O’Hagan", 'McCrindle', 'Flannery', 'Wright', 'McKendry', 'Maitland', 'Constantinou', 'Cannon', 'Arshad', 'Dara', 'Jarvis', 'Welsh']
gymclass_names = ['Body Combat', 'Yoga', 'Weights', 'Spin', 'Pump', 'Bootcamp', 'Kettlebells', 'Circuits', 'Abs']
gymclass_sizes = [5,10,15]

# create 50 sample members
puts 'generating 50 members...'
for i in 1..50
  member_name = "#{member_first_names.sample()} #{member_second_names.sample()}"
  member1 = Member.new({'name' => member_name, 'premium' => membership_type.sample()})
  member1.save()
end

puts 'generating daily 7am class for a 3 months...'
# let's create a years worth of stuff!
days = 365/4
# Every day at 07:00 setup Bootcamp
starttime7 = Time.parse('07:00', Time.now())
for i in 0..days do
  newtime = starttime7 + (60*60*24*i)
  gymclass1 = GymClass.new({'name' => gymclass_names[5], 'time' => newtime, 'spaces' => 10})
  gymclass1.save()
end

puts 'generating daily 6pm class for a 3 months...'
# Every day at 18:00 setup Circuits
starttime18 = starttime7 + (60*60*11)
for i in 0..days do
  newtime = starttime18 + (60*60*24*i)
  gymclass1 = GymClass.new({'name' => gymclass_names[7], 'time' => newtime, 'spaces' => 10})
  gymclass1.save()
end

puts "generating #{days*14} hourly timeslots for a 3 months..."
# generate hour timeslots for the next 365 days from 8 - 10pm
hour = 60*60
starttime8 = starttime7 + hour
time_array = [starttime8]
for i in 0..days
  starttime = starttime8 + (60*60*24*i)
  time_array.push(starttime)
  for i in 1..14
    time_array.push(starttime + (hour*i))
  end
end

puts "generating #{(7*365)/4} classes for a 3 months..."
three_monthly_avg_classes = (7*365)/4
# generate 50 random classes throughout the next 365 days
for i in 1..three_monthly_avg_classes
  gymclass1 = GymClass.new({'name' => gymclass_names.sample(), 'time' => time_array.sample(), 'spaces' => gymclass_sizes.sample()})
  gymclass1.save()
end

puts "generating #{(52*100)/4} bookings for a 3 months..."
# reckon we need 100*52 bookings to avaerage out over the year..
# create 100 random class bookings over the classes
three_months_bookings = (52/4)*100
for i in 1..three_months_bookings
  gymclass = GymClass.all().sample()
  params = {'member_id' => gymclass.available_members().sample().id, 'gymclass_id' => gymclass.id}
  booking = Booking.new(params)
  booking.save()
  gymclass.decrease_spaces()
  gymclass.update()
end

# binding.pry

# nil