require 'board'

describe Move do

  before(:each) do
    @move1 = Move.new(1,1)
  end

  it "is comparable" do
    move2 = Move.new(1,1)
    @move1.should == move2
  end

  it "can only compare to a Move" do
    class Other
      attr_reader :row, :column
      def initialize(row, column)
        @row, @column = row, column
      end
    end
    @move1.should_not == Other.new(1,1)
  end

  it "stores a player value" do
    @move1.player_value.should == 1
  end
end
