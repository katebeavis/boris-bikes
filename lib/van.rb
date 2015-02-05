require_relative 'bike_container'

class Van

	include BikeContainer

	def collect_broken_bikes_from(station)
		station.broken_bikes.each do |broken_bike|
			dock(station.release(broken_bike))
		end
	end

	def take_broken_bikes_to(garage)
		bikes.each do |bike|
			release(bike)
			garage.dock(bike)
		end
	end



end