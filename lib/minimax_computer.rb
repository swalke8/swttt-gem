class MinimaxComputer

  def initialize(board, observer)
    @game_board = board
    @observer = observer
    @first_move = [Move.new(0,0),
                   Move.new(0,@game_board.dimension-1),
                   Move.new(@game_board.dimension-1,0),
                   Move.new(@game_board.dimension-1, @game_board.dimension-1)]
    @self_value = @game_board.player_value
  end

  def make_move(iteration = 0)
    if @observer.game_over?
      return -@game_board.player_value if @observer.has_winner?
      return 0
    elsif first_move?
      make_first_move
    else
      perform_mini_max(iteration)
    end
  end

private

  def perform_mini_max(iteration)
    best_value, best_moves = nil, []
    (0...@game_board.dimension).each do |row|
      (0...@game_board.dimension).each do |column|
        path_value = 0
        if @game_board.is_empty_at?(row, column)
          @game_board.move(row, column)
          path_value += make_move(iteration + 1)
          break if @observer.game_over? && iteration.zero?
          @game_board.undo_move
          if better_move?(best_value, path_value)
            best_moves.clear if path_value != best_value
            best_value = path_value
            best_moves << Move.new(row, column)
          end
        end
      end
    end
    return best_value if !iteration.zero?
    move = best_moves[rand(best_moves.size)]
    @game_board.move(move.row, move.column) if !@observer.game_over?
  end

  def check_position(row, column, path_value, iteration)
    
  end

  def better_move?(best_value, path_value)
    (best_value.nil?) or
    (path_value >= best_value && @game_board.player_value == @self_value) or
    (path_value <= best_value && @game_board.player_value != @self_value)
  end

  def first_move?
    @game_board.number_of_moves_made < 2
  end

  def make_first_move
    if !@first_move.include?(@game_board.game_history.first)
      move = @first_move[rand(@first_move.size)]
    else
      middle = @game_board.dimension/2
      move = Move.new(middle, middle)
    end
    @game_board.move(move.row, move.column)
  end
end
