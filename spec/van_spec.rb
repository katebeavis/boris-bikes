require 'van'
require 'bike'

describe Van do

	let(:van) { Van.new }
	let(:broken_bike){double :bike, broken?: true}
	let(:station) {double :station, broken_bikes: [broken_bike]}
  let(:garage) {double :garage}

	it 'can collect broken bikes from a docking station' do
		# we need a station with broken bikes
		# we need a van, broken bike
		# when i collect the broken bikes from station, i have those bikes and the station doesn't
		expect(station).to receive(:release).with(broken_bike).and_return(broken_bike)
		van.collect_broken_bikes_from(station)
		expect(van.unavailable_bikes).to eq [broken_bike]
	end

	it 'should take broken bikes to a garage' do
		allow(garage).to receive(:dock)
  		van.dock(broken_bike)
  		van.take_broken_bikes_to(garage)
  		expect(van.bikes).to be_empty
	end

	it "should give the bikes to the garage when dropping them of" do
		van.dock(broken_bike)
		expect(garage).to receive(:dock).with broken_bike
		van.take_broken_bikes_to(garage)
	end

end