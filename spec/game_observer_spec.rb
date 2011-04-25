require 'game_observer'
require 'board'

describe GameObserver do

  before(:each) do
    @my_board = Board.new
    @observer = GameObserver.new(@my_board)
  end

  def single_loop
    (0...@my_board.dimension).each do |value|
      yield(value)
    end
  end

  def check_for_winners
    single_loop do |row|
      single_loop do |column|
        yield(row, column)
      end
      (@observer.winner?).should == true
      single_loop do |column|
        @my_board.set_value_at(row,column,0)
      end
    end
  end

  it "should create a new Game Observer" do
    @observer.nil?.should_not == true
  end
  
  it "should detect a horizontal win" do
    check_for_winners do |row, column|
      @observer.winner?.should == false
      @my_board.set_value_at(row,column,1)
    end
  end

  it "should detect a vertical win" do
    check_for_winners do |row, column|
      @observer.winner?.should == false
      @my_board.set_value_at(column,row,-1)
    end
  end

  it "should detect a left diagonal win" do
    single_loop do |row_column_value|
      @observer.winner?.should == false
      @my_board.set_value_at(row_column_value, row_column_value, 1)
    end
    @observer.winner?.should == true
  end

  it "should detect a right diagonal win" do
    single_loop do |row_column_value|
      @observer.winner?.should == false
      @my_board.set_value_at(@my_board.dimension-row_column_value-1, row_column_value, 1)
    end
    @observer.winner?.should == true
  end
end
