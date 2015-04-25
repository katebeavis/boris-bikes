require 'docking_station'

describe DockingStation do
  subject { described_class.new(capacity: 20) }
  let(:bike) { double :bike }
  let(:working_bike) { double :bike, broken?: false }
  let(:broken_bike) { double :bike, broken?: true }

  it 'accepts a bike' do
    expect { subject.dock(bike) }.to change { subject.bike_count }.by 1
  end

  it 'releases a working bike' do
    subject.dock(working_bike)
    expect { subject.release(working_bike) }.to change { subject.bike_count }.by(-1)
  end

  it 'knows when it\'s full' do
    expect(subject).not_to be_full
    subject.capacity.times { subject.dock(bike) }
    expect(subject).to be_full
  end

  it 'does not accept a bike if it\'s full' do
    subject.capacity.times { subject.dock(bike) }
    expect { subject.dock(bike) }.to raise_error(RuntimeError, 'Station is full')
  end

  it 'provides the list of available bikes' do
    subject.dock(working_bike)
    expect(subject.available_bikes).to eq([working_bike])
  end

  it 'does not release a bike that isn\'t there' do
    expect { subject.release(bike) }.to raise_error(RuntimeError, 'No bikes available')
  end

  it 'provides the list of unavailable bikes' do
    subject.dock(broken_bike)
    expect(subject.unavailable_bikes).to eq([broken_bike])
  end
end
