require 'station'

describe Station do

describe '#name' do
  it { is_expected.to respond_to(:name) }
end


describe '#zone' do
  it { is_expected.to respond_to(:zone) }
end

end
