# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

    Event.create(name: "first")
    Event.create(name: "second")
    Event.create(name: "third")
    Event.create(name: "fourth")


    User.create(name: "Luka")
    User.create(name: "Martina")
    User.create(name: "Katarina")
    User.create(name: "Biserka")
    User.create(name: "Marko")
    User.create(name: "Jelena")


    Status.create(name: "approved",title: "Schvaleno")
    Status.create(name: "reserved",title: "Rezervovano")
  
    
    

#    Eventuser.create(status_id:2,event_id:1,user_id:1)
#    Eventuser.create(status_id:1,event_id:1,user_id:2)
#    Eventuser.create(status_id:1,event_id:1,user_id:3)
#    Eventuser.create(status_id:2,event_id:1,user_id:4)
#    Eventuser.create(status_id:2,event_id:2,user_id:1)
#    Eventuser.create(status_id:3,event_id:2,user_id:2)
#    Eventuser.create(status_id:2,event_id:2,user_id:3)
#    Eventuser.create(status_id:3,event_id:3,user_id:1)
#

#    Day.create(date:  Date.new( 2013, 05, 31))
#    Day.create(date:  Date.new( 2013, 06, 1 ))
#    Day.create(date:  Date.new( 2013, 06, 2 ))
#    Day.create(date:  Date.new( 2013, 06, 3 ))
#    Day.create(date:  Date.new( 2013, 06, 4 ))
#    Day.create(date:  Date.new( 2013, 05, 1 ))
#    Day.create(date:  Date.new( 2013, 05, 2 ))
#    Day.create(date:  Date.new( 2013, 05, 3 ))
#    Day.create(date:  Date.new( 2013, 05, 4 ))
#    Day.create(date:  Date.new( 2013, 05, 5 ))
#    Day.create(date:  Date.new( 2013, 05, 6 ))
#    Day.create(date:  Date.new( 2013, 05, 7 ))
#    Day.create(date:  Date.new( 2013, 05, 4 ))
#
    Shift.create(name: "day")
    Shift.create(name: "night")

#    DayCollection.create(day_id:1,user_id:1,status_id:2,shift_id:1)
#    DayCollection.create(day_id:1,user_id:2,status_id:1,shift_id:1)
#    DayCollection.create(day_id:1,user_id:3,status_id:2,shift_id:2)
