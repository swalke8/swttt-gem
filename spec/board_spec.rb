require 'board'

describe Board do

  before(:each) do
    @my_board = Board.new
  end
  
  def loop_board
    (0..2).each do |value|
      yield(value)
    end
  end

  it "should create a board" do
    @my_board.nil?.should == false
  end

  it "should initialize an empty board" do
    (0...@my_board.row).each do |row|
      (0...@my_board.column).each do |column|
        @my_board.game_board[row][column].should == 0
      end
    end
  end

  it "should check to see if a position is open" do
    (0...@my_board.row).each do |row|
      (0...@my_board.column).each do |column|
        @my_board.is_position_open?(row, column).should == true
      end
    end
  end

  it "should be able to set a position's value" do
    @my_board.set_value_at(1,1,-1)
    (@my_board.game_board[1][1]).should == -1
  end

  it "should return the sum of a row" do
    #(0..2).each do |value|
    #  @my_board.sum_of_row[1].should == value
    #  @my_board.set_value_at(1,value,1)
    #end
    loop_board do |value|
      @my_board.sum_of_row[1].should == value
      @my_board.set_value_at(1, value, 1)
    end
    
    @my_board.sum_of_row[1].should == 3
  end

  it "should return the sum of a column" do
    (0..2).each do |value|
      @my_board.sum_of_column[2].should == value
      @my_board.set_value_at(value,2,1)
    end
    @my_board.sum_of_column[2].should == 3
  end

  it "should return the sum of a diagonal" do
   # (0..2).each do |value|
   # @my_board.sum_of_left_diagonal.should == 0
   # @my_board.sum_of_right_diagonal.should == 0
   # @my_board.set_value_at(1,1,1)
   # @my_board.sum_of_left_diagonal.should == 1
   # @my_board.sum_of_right_diagonal.should == 1
   # end
  end
end
