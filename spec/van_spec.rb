require 'van'

describe Van do
  subject { described_class.new(capacity: 30) }
  let(:broken_bike) { double :bike, broken?: true }
  let(:working_bike) { double :bike, broken?: false }
  let(:station) { double :station, broken_bikes: [broken_bike], working_bikes: [working_bike] }
  let(:garage) { double :garage, broken_bikes: [broken_bike], working_bikes: [working_bike] }
  let(:bike) { double :bike }

  it 'can collect broken bikes from a docking station' do
    expect(station).to receive(:release).with(broken_bike).and_return(broken_bike)
    subject.collect_broken_bikes_from(station)
    expect(subject.unavailable_bikes).to eq [broken_bike]
  end

  it 'gives the bikes to the garage when dropping them off' do
    subject.dock(broken_bike)
    expect(garage).to receive(:dock).with broken_bike
    subject.take_broken_bikes_to(garage)
  end

  it 'collects working bikes from the garage' do
    expect(garage).to receive(:release).with(working_bike).and_return(working_bike)
    subject.collect_working_bikes_from(garage)
    expect(subject.available_bikes).to eq [working_bike]
  end

  it 'takes working bikes to the docking station' do
    subject.dock(working_bike)
    expect(station).to receive(:dock).with working_bike
    subject.take_working_bikes_to(station)
  end

  it 'knows when it\'s full' do
    expect(subject).not_to be_full
    subject.capacity.times { subject.dock(bike) }
    expect(subject).to be_full
  end
end
