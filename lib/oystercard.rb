class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_CHARGE = 1

  attr_reader :balance, :in_journey

  def initialize
    @balance = 0
    @in_journey = in_journey
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + @balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    fail "Insufficient funds" if @balance < MINIMUM_CHARGE
    @in_journey = true
    puts "Card touched in. Remaining balance is #{@balance}"
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    @in_journey = false
    puts "Card touched out. Remaining balance is #{@balance}"
  end

  def in_journey?
    @in_journey
  end

end
