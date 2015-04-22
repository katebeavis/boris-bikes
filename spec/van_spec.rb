require 'van'

describe Van do
	let(:van) { Van.new(capacity: 30) }
	let(:broken_bike) { double :bike, broken?: true }
	let(:working_bike) { double :bike, broken?: false }
	let(:station) { double :station, broken_bikes: [broken_bike], working_bikes: [working_bike] }
	let(:garage) { double :garage, broken_bikes: [broken_bike], working_bikes: [working_bike] }
	let(:bike) { double :bike }

	it 'can collect broken bikes from a docking station' do
		expect(station).to receive(:release).with(broken_bike).and_return(broken_bike)
		van.collect_broken_bikes_from(station)
		expect(van.unavailable_bikes).to eq [broken_bike]
	end

	it 'should give the bikes to the garage when dropping them off' do
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

	it 'should know when it\'s full' do
		expect(van).not_to be_full
		van.capacity.times { van.dock(bike) }
		expect(van).to be_full
	end
end
