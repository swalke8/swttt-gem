require 'board'

describe Board do

  before(:each) do
    @my_board = Board.new
  end

  def double_loop
    single_loop do |row|
      single_loop { |column| yield(row, column) }
    end
  end

  def single_loop
    (0...@my_board.dimension).each do |value|
      yield(value)
    end
  end

  ###############################################

  it "should create a board" do
    @my_board.nil?.should == false
  end

  it "should initialize an empty board" do
    double_loop { |row, column| @my_board.game_board[row][column].should == 0 }
  end

  it "should check to see if a position is open" do
    double_loop { |row, column| @my_board.is_position_open?(row, column).should == true }
  end

  it "should be able to set a position's value" do
    @my_board.set_value_at(1,1,-1)
    @my_board.game_board[1][1].should == -1
  end

  it "should return the sum of a row" do
    single_loop do |value|
      @my_board.sum_of_row[1].should == value
      @my_board.set_value_at(1, value, 1)
    end
    @my_board.sum_of_row[1].should == @my_board.dimension
  end

  it "should return the sum of a column" do
    single_loop do |value|
      @my_board.sum_of_column[0].should == value
      @my_board.set_value_at(value,0,1)
    end
    @my_board.sum_of_column[0].should == @my_board.dimension
  end

  it "should return the sum of a diagonal" do
    single_loop do |value|
      @my_board.sum_of_left_diagonal.should == value
      @my_board.sum_of_right_diagonal.should == value
      @my_board.set_value_at(value,value,1)
      @my_board.set_value_at(value, @my_board.dimension-value-1, 1) if value != (@my_board.dimension/2).ceil
    end
    @my_board.sum_of_left_diagonal.should == @my_board.dimension
    @my_board.sum_of_right_diagonal.should == @my_board.dimension
  end

  it "should check for a full board" do
    double_loop { |row, column| @my_board.set_value_at(row, column, 1) }
    @my_board.full?.should == true
  end
end

