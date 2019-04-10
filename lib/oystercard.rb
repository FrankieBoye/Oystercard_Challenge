class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_CHARGE = 1

  attr_reader :balance, :in_journey, :entry_station

  def initialize
    @balance = 0
    @in_journey = false
    @entry_station = station
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
    @in_journey = true
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    @entry_station = nil
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

end
