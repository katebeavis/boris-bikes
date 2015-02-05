require_relative 'bike_container'

class Van

	include BikeContainer

	def initialize(options = {})
		self.capacity = options.fetch(:capacity, capacity)
	end

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

	def collect_working_bikes_from(garage)
		garage.working_bikes.each do |working_bike|
			dock(garage.release(working_bike))
		end
	end

	def take_working_bikes_to(station)
		bikes.each do |bike|
			release(bike)
			station.dock(bike)
		end
	end



end