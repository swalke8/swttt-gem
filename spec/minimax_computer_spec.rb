require 'minimax_computer'

describe MinimaxComputer do

  before(:each) do
    @computer = MinimaxComputer.new
  end

  it "should create a new minimax player" do
    @computer.nil?.should_not == true
  end

end
