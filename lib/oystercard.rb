class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_CHARGE = 1

  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
    @entry_station = entry_station
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + @balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in(station)
    fail "Insufficient funds" if @balance < MINIMUM_CHARGE
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    @entry_station = nil

  end

  def in_journey?
  # correct one line (true) syntax would be !!entry_station
  if @entry_station == nil
    false
  else
    true
  end
  end

end
