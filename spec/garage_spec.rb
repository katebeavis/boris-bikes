require 'garage'
#require 'bike_container'

describe Garage do

  let(:garage) { Garage.new }
  let(:broken_bike) {double :bike, broken?: true}
  let(:van) {double :van}


   it 'should fix broken bikes' do
     expect(broken_bike).to receive(:fix!)
     garage.dock(broken_bike)
   end








end