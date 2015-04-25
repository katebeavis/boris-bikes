require 'bike'

describe Bike do
  subject { described_class.new }

  it 'is not be broken after it is created' do
    expect(subject).not_to be_broken
  end

  it 'is able to break' do
    subject.break
    expect(subject).to be_broken
  end

  it 'is able to get fixed' do
    subject.break
    subject.fix
    expect(subject).not_to be_broken
  end
end
