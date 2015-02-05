require 'garage'
#require 'bike_container'

describe Garage do

  let(:garage) { Garage.new(capacity: 1) }
  let(:broken_bike) {double :bike, broken?: true}
  let(:van) {double :van}

  it 'should allow deafult capacity on initializing' do
    expect(garage.capacity).to eq(1)
  end


   it 'should dock and fix broken bikes' do
     expect(broken_bike).to receive(:fix!)
     garage.dock(broken_bike)
   end








end