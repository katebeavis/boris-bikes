require 'van'

describe Van do

	let(:van) { Van.new }
	let(:broken_bike){double :bike, broken?: true}
	let(:working_bike){double :bike, broken?: false}
	let(:station) {double :station, broken_bikes: [broken_bike], working_bikes: [working_bike]}
  	let(:garage) {double :garage, broken_bikes: [broken_bike], working_bikes: [working_bike]}

	it 'can collect broken bikes from a docking station' do
		# we need a station with broken bikes
		# we need a van, broken bike
		# when i collect the broken bikes from station, i have those bikes and the station doesn't
		expect(station).to receive(:release).with(broken_bike).and_return(broken_bike)
		van.collect_broken_bikes_from(station)
		expect(van.unavailable_bikes).to eq [broken_bike]
	end

	# it 'should take broken bikes to a garage' do
	# 	allow(garage).to receive(:dock)
 #  		van.dock(broken_bike)
 #  		van.take_broken_bikes_to(garage)
 #  		expect(van.bikes).to be_empty
	# end

	it "should give the bikes to the garage when dropping them off" do
		van.dock(broken_bike)
		expect(garage).to receive(:dock).with broken_bike
		van.take_broken_bikes_to(garage)
	end

	  it 'should collect working bikes from the garage' do
		expect(garage).to receive(:release).with(working_bike).and_return(working_bike)
	 	van.collect_working_bikes_from(garage)
	 	expect(van.available_bikes).to eq [working_bike]
	   end

	   it 'should take working bikes to the docking station' do
	   van.dock(working_bike)
	   expect(station).to receive(:dock).with working_bike
	   van.take_working_bikes_to(station)
	   end

end