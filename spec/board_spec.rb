require 'board'

describe Board do

  before(:each) do
    @my_board = Board.new
  end

  def iterate_board
    (0..@my_board.dimension).each do |row|
      (0..@my_board.dimension).each do |column| 
        yield(row, column)
      end
    end
  end

  it "should create a board" do
    @my_board.nil?.should == false
  end

  it "should check for a full board" do
    iterate_board { |row, column| @my_board.move(row, column) }
    @my_board.full?.should == true
  end

  context "game history" do
    it "is empty" do
      @my_board.game_history == []
    end

    before do
      @my_board.move(1,1)
    end

    it "has a move" do
      @my_board.game_history.should == [Move.new(1,1)]
    end

    it "can recall last move" do
      @my_board.game_history.last.should == Move.new(1,1)
    end

    it "can undo the last move" do
      @my_board.move(1,2)
      @my_board.game_history.last.should == Move.new(1,2,-1)
      @my_board.undo_move
      @my_board.game_history.should == [Move.new(1,1,1)]
    end

    it "decrements the number of moves" do
      @my_board.undo_move
      @my_board.number_of_moves_made.should == 0
    end
  end

  it "has a player value" do
    @my_board.player_value.should == 1
  end

  it "should update the player value with each move" do
    @my_board.move(1,2)
    @my_board.player_value.should == -1
  end

  it "should update the player value with each undo" do
    @my_board.move(1,1)
    @my_board.undo_move
    @my_board.move(1,2)
    @my_board.player_value.should == -1
  end

  it "can override the player_value" do
    @my_board.move(1,2,1)
    @my_board.move(0,0,1)
    @my_board.player_value.should == 1
  end

  it "has a 3x3 board" do
    @my_board.board.size.should == 3
    @my_board.board[1].size.should == 3
  end

  it "updates the board when move is called" do
    @my_board.move(0,0)
    @my_board.board[0][0].should == 1
  end

  it "undos the board" do
    @my_board.move(2,2)
    @my_board.undo_move
    @my_board.board[2][2].should == 0
  end

  context "sum values" do

    before do
      @my_board.move(1,1)
    end

    it "should update row scores" do
      @my_board.row_scores[1].should == 1
    end

    it "should update column scores" do
      @my_board.column_scores[1].should == 1
    end

    it "should update the diagonal scores" do
      @my_board.left_diagonal_score.should == 1
      @my_board.right_diagonal_score.should == 1
    end

    it "should undo row scores" do
      @my_board.undo_move
      @my_board.row_scores[1].should == 0
    end

    it "should undo column scores" do
      @my_board.undo_move
      @my_board.column_scores[1].should == 0
    end

    it "should undo diagonal scores" do
      @my_board.undo_move
      @my_board.left_diagonal_score.should == 0
      @my_board.right_diagonal_score.should == 0
    end
  end
end
