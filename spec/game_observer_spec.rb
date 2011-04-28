require 'game_observer'
require 'board'

describe GameObserver do
  
  before(:each) do
    @my_board = Board.new
    @observer = GameObserver.new(@my_board)
  end
  
  def loop
    (0...@my_board.dimension).each { |position| yield(position) }
  end

  it "detects a horizontal win" do
    loop { |column| @my_board.move(0,column,1) }
    @observer.has_winner?.should == true
  end

  it "detects a vertical win" do
    loop { |row| @my_board.move(row,0,1) }
    @observer.has_winner?.should == true
  end

  it "detects a left diagonal win" do
    loop { |position| @my_board.move(position,position,1) }
    @observer.has_winner?.should == true
  end

  it "detects a right diagonal win" do
    loop { |position| @my_board.move(@my_board.dimension-position-1,position,1) }
    @observer.has_winner?.should == true
  end

  it "detects if the game is over" do
    loop { |row| loop { |column| @my_board.move(row, column, 2) } }
    @observer.game_over?.should == true
  end
end
