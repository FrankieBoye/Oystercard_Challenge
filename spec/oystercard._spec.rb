require 'oystercard'

describe Oystercard do

  let(:station) { double :station }

  it 'checks the new card has a balance' do
    expect(subject.balance).to eq(0)
  end

  it 'shows list of previous trips' do
    expect(subject.trips).to be_empty
  end

  it { is_expected.to respond_to(:touch_in).with(1).argument }
  it { is_expected.to respond_to(:touch_out).with(1).argument }

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up the balance' do
      expect{ subject.top_up 1 }.to change { subject.balance }.by 1
    end

    it 'raises an error if the maximum balance is exceeded' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up maximum_balance
      expect{ subject.top_up 1 }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
    end
  end

  it 'can deduct the balance' do
    expect{ subject.deduct 10 }.to change { subject.balance }.by -10
  end

  it 'responds to touch_in' do
    subject.top_up(Oystercard::MINIMUM_CHARGE)
    subject.touch_in(station)
    expect(subject.in_journey?).to eq true
  end

  it 'responds to touch_out' do
    subject.top_up(1)
    subject.touch_in(station)
    subject.touch_out(station)
    expect(subject.in_journey?).to eq false
  end

  it 'expects to start initially not in journey' do
    expect(subject).not_to be_in_journey
  end

  it 'charges the card on touch_out' do
    expect { subject.touch_out(station) }.to change { subject.balance }.by( -Oystercard::MINIMUM_CHARGE)
  end

  describe '#touch_in' do
  it 'raises error if insufficient funds on touch in' do
    expect { subject.touch_in(station) }.to raise_error "Insufficient funds"
  end

  it 'stores the entry station' do
    subject.top_up(1)
    allow(subject).to receive(:entry_station) {station}
    subject.touch_in(station)
    expect(subject.entry_station).to eq station
  end
  end

  it 'stores the exit station' do
    allow(subject).to receive(:exit_station) {station}
    subject.touch_out(station)
    expect(subject.exit_station).to eq station
  end

  it "stores one journey" do
    subject.top_up(10)
    subject.touch_in("Aldgate")
    subject.touch_out("London Bridge")
    expect(subject.trips).to eq [{entry: "Aldgate", exit: "London Bridge"}]
  end

  it "trips has an empty list of journeys by default" do
    expect(subject.trips).to eq []
  end
end
