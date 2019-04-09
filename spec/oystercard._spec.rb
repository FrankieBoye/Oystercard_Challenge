require 'oystercard'

describe Oystercard do
  it 'checks the new card has a balance' do
    expect(subject.balance).to eq(0)
  end

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

  # it 'responds to touch_in' do
  #   subject.touch_in
  #   expect(subject).to be_in_journey
  # end

  # it 'responds to touch_out' do
  #   subject.touch_in
  #   subject.touch_out
  #   expect(subject).to respond_to :touch_out
  # end

  it 'expects to start initially not in journey' do
    expect(subject).not_to be_in_journey
  end

  it 'raises error if insufficient funds on touch in' do
    expect { subject.touch_in }.to raise_error "Insufficient funds"
  end

end
