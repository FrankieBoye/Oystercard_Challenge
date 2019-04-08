require 'oystercard'

describe Oystercard do
it "checks the new card has a balance" do
  expect(subject.balance).to eq (0)
end

end
