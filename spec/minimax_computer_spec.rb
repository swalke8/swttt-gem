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
    @my_board.move(2,1)
    @my_board.move(3,3)
    @my_board.move(2,2)
    @my_board.move(2,3)
    @my_board.move(1,1)
    @computer.move
    @observer.has_winner?.should be_true
    @my_board.number_of_moves_made.should == 6
  end

  it "takes a corner or middle piece for first move" do
    @my_board.move(2,3)
    @computer.move
    [Move.new(1,1), Move.new(1,3), Move.new(3,1), Move.new(3,3), Move.new(2,2)].include?(@my_board.game_history.last).should be_true
  end

  it "blocks immediate losses" do
    @my_board.move(2,3)
    @computer.move
    @my_board.move(1,3)
    @computer.move
    @my_board.value_at(3,3).should == -1
  end
end
