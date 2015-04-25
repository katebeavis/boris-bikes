require 'garage'

describe Garage do
  subject { described_class.new(capacity: 1) }
  let(:broken_bike) { double :bike, broken?: true }
  let(:van) { double :van }

  it 'allows default capacity on initializing' do
    expect(subject.capacity).to eq(1)
  end

  it 'can dock and fix broken bikes' do
    expect(broken_bike).to receive(:fix!)
    subject.dock(broken_bike)
  end
end
