class Game

  def initialize
    @board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    draw_board
    check_winner
  end

  def draw_board
    puts ["     |     |     ",
          "  #{@board[0][0]}  |  #{@board[0][1]}  |  #{@board[0][2]}  ",
          "     |     |     ",
          "-----+-----+-----",
          "     |     |     ",
          "  #{@board[1][0]}  |  #{@board[1][1]}  |  #{@board[1][2]}  ",
          "     |     |     ",
          "-----+-----+-----",
          "     |     |     ",
          "  #{@board[2][0]}  |  #{@board[2][1]}  |  #{@board[2][2]}  ",
          "     |     |     "]
  end

  def play_round(player, space)  # To do: check that move is valid
    @cell = space - 1
    @cell_x = (@cell / 3).floor
    @cell_y = @cell % 3
    @board[@cell_x][@cell_y] = player
    draw_board
    check_winner
  end

  def check_winner
    @diagonals = [[@board[0][0], @board[1][1], @board[2][2]], [@board[0][2], @board[1][1], @board[2][0]]]
    @lines = @board + @board.transpose + @diagonals
    if @lines.include?(["X", "X", "X"])
      puts "Three in a row! X wins!"
    elsif @lines.include?(["O", "O", "O"])
      puts "Three in a row! O wins!"
    end
  end

end

game = Game.new
game.play_round("X", 4)
game.play_round("O", 5)
game.play_round("X", 1)
game.play_round("O", 7)
game.play_round("X", 3)
game.play_round("O", 6)
game.play_round("X", 2)