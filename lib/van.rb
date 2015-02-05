require_relative 'bike_container'

class Van

	include BikeContainer

	def collect_broken_bikes_from(station)
		station.broken_bikes.each do |broken_bike|
			dock(station.release(broken_bike))
		end
	end

	def bikes_to_garage(bike)
		
	end



end