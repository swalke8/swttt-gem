class MinimaxComputer

  def initialize(board, observer)
    @game_board, @observer = board, observer
    @first_move = [Move.new(0,0),
                   Move.new(0,@game_board.dimension),
                   Move.new(@game_board.dimension,0),
                   Move.new(@game_board.dimension, @game_board.dimension)]
    @my_player_value = @game_board.player_value
  end

  def move(iteration = 0)
    if first_move?
      make_first_move
    else
      perform_mini_max(iteration)
    end
  end

private

  def first_move?
    @game_board.number_of_moves_made < 2
  end

  def make_first_move
    move = select_first_move
    @game_board.move(move.row, move.column)
  end

  def select_first_move
    return corner_move if all_board_corners_open?
    return middle_move
  end

  def all_board_corners_open?
    !@first_move.include?(@game_board.game_history.first)
  end

  def corner_move
    @first_move[rand(@first_move.size)]
  end

  def middle_move
    middle = @game_board.dimension/2
    return move = Move.new(middle, middle)
  end

  def perform_mini_max(iteration)
    return path_score if @observer.game_over?
    best_moves = BestMove.new(@game_board, @my_player_value)
    for_each_cell { |row, column| best_moves.add_better_move(best_moves.value, calculate_path_score(row, column,iteration),
                                  Move.new(row, column)) if @game_board.is_empty_at?(row, column) }
    return best_moves.value if !iteration.zero?
    move = best_moves.get_random_move
    @game_board.move(move.row, move.column)
  end

   def for_each_cell
    (0..@game_board.dimension).each do |row|
      (0..@game_board.dimension).each { |column| yield(row, column) }
    end
  end

  def path_score
    return -@game_board.player_value if @observer.has_winner?
    return 0
  end

  def calculate_path_score(row, column, iteration)
    @game_board.move(row, column)
    score = calculate_score(iteration)
    @game_board.undo_move
    return score
  end

  def calculate_score(iteration)
    if immediate_win?(iteration)
      return infinity
    else
      return perform_mini_max(iteration + 1)
    end
  end

  def immediate_win?(iteration)
    iteration.zero? && @observer.has_winner?
  end

  def infinity
    -@game_board.player_value * 1.0/0.0
  end
end

class BestMove
  attr_accessor :moves, :value
  def initialize(game_board, my_player_value)
    @moves = []
    @value = nil
    @game_board, @my_player_value = game_board, my_player_value
  end

  def get_random_move
    @moves[rand(@moves.size)]
  end

  def add_better_move(best_score, path_score, move)
    if better_or_equal_move?(best_score, path_score)
      @moves.clear and @value = path_score if path_score !=  @value
      @moves << move
    end
  end

  def better_or_equal_move?(best_score, path_score)
    (best_score.nil?) or
    (path_score >= best_score && @game_board.player_value == @my_player_value) or
    (path_score <= best_score && @game_board.player_value != @my_player_value)
  end
end
