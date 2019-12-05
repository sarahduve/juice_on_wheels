# README

## Set up
`rake db:setup` Should create 100 vehicles, and park them around Brooklyn

## Server

`rails server`

## Tests

`bundle exec rspec spec/controllers/api`

## Intro and Background
Some kick scooter share startups like Lime and Bird are dependent on independent contractors
known as Juicers or Chargers, who collect scooters at night, bring them home to
charge, and then set them out first thing in the morning at designated
locations. Others like Lyft use employees for this task, but it still presents a
novel type of traveling salesman problem for the sharing economy: how to find
the most efficient route that "visits" a given number of scooters in a given area.\*

This app is designed to address a similar issue with some key differences.
Rather than kick scooters, here the vehicle in question is a moped, which because of
the obvious size difference, have their batteries swapped out wholesale on the
spot rather than being brought to a charging location (which is conveniently
more straightforward to mock out in code!). And like Lyft, this work
is done by employees rather than contractors. At its core is an API which
supports the creation and management of "battery swapping shifts", via the
following core functions/endpoints:

* shift creation
* adding vehicles to a shift -- both manually and automatically, the latter which given a
starting latitude and longitude pair, assigns the 20 closest vehicles to a shift and
returns them in the optimal order to be serviced
* reviewing all vehicles in a shift
* completing a battery swap for a particular vehicle
* checking if a swap has been completed for any given vehicle in a particular shift
* checking if all vehicles in a shift have had their battery
swaps

One can envision this API being consumed both by a mobile app used by
battery swappers on the job, as well as a web app used by management to monitor
employee efficiency and performance.

\*This is a gross oversimplification of how juicing bounty programs
  work in practice. Often, the scooters are hard to find, competition is
  cutthroat, and the system easily gamed.

## Other notes
* For simplicity here, there is no battery mode and instead is currently just mocked out by just setting the
vehicle's `battery_level` to 1. In reality, batteries are precious inventory we
would definitely want to track in a database by serial number etc.

* Also for simplicity, route order is based on Euclidean distance rather than
  actual roads that need to be traveled upon and their associated traffic
  levels.

* Auto shift creation is currently achieved by hitting the same shift creation endpoint
  but with optional lat/long params

* I'm using the geocoder gem for distance calculation, which uses Nominatim by
  default, and has some _interesting_ user-created display names for neighborhoods

## TODO
- [ ] Move remaining logic out of controllers, and use serializers or model
  methods where appropriate
- [ ] Model tests where appropriate
- [ ] Serializer tests
- [ ] Nothing is currently ever setting shift complete status to true (all shift
  assignment statuses are being set individually and the status of an entire shift is
  checked by checking all assignment statuses). It's possible this doesn't need to
  be a column on Shift at all and just an instance method?
- [ ] If a shift is happening during operating hours, a vehicle may be in use
  and long gone from its original given location at shift creation. Perhaps for
  daytime shifts, for optimal route finding a separate endpoint is necessary which only doles out one
  vehicle at a time, based on which is a) closest to the swapper's current
  location b) not in use c) below a certain battery level?
- [ ] Should `BatteryShift` be in charge of assigning vehicles to itself, or
  does this call for a service object like a VehicleAssigner
- [ ] Improvements to auto-assign algo
