class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_CHARGE = 1

  attr_reader :balance, :entry_station, :trips, :exit_station

  def initialize
    @balance = 0
    @entry_station = entry_station
    @trips = []
    @exit_station = exit_station
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

  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    @trips << {entry: entry_station, exit: station}
    @entry_station = nil
    @exit_station = station
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
