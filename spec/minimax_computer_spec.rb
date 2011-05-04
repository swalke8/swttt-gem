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
    @computer.nil?.should be_false
  end

  it "has a move" do
    @computer.move.nil?.should be_false
  end

  it "always end in a cats game" do
    (0...9).each { @computer.move }
    @observer.game_over?.should be_true
    @observer.has_winner?.should be_false
  end

  it "takes an immediate win" do
    @my_board.move(1,0)
    @my_board.move(2,2)
    @my_board.move(1,1)
    @my_board.move(1,2)
    @my_board.move(0,0)
    @computer.move
    @observer.has_winner?.should be_true
    @my_board.number_of_moves_made.should == 6
  end
end
