require 'human_player'
require 'board'

describe HumanPlayer do

  before(:each) do
    @board = Board.new
    @player = HumanPlayer.new(@board)
  end

  it "should take a move" do
    @player.move(1,2).should be_true
  end

  it "should make a move" do
    @player.move(1,2)
    @board.is_empty_at?(1,2).should be_false
  end

  it "cannot move on an occupied space" do
    @player.move(0,0)
    @player.move(0,0).should be_false
  end

end
