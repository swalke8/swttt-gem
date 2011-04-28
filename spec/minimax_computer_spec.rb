require 'minimax_computer'
require 'board'
require 'game_observer'

describe MinimaxComputer do

  before(:each) do
    @my_board = Board.new
    @observer = GameObserver.new(@my_board)
    @computer = MinimaxComputer.new(@my_board, @observer)
  end

 
  it "has a minimax player" do
    @computer.nil?.should_not == true
  end

 it "should print" do
    (0...9).each do
      @computer.make_move
    end
    @my_board.print
    @observer.game_over?.should be_true
    @observer.has_winner?.should be_false
  end
end
