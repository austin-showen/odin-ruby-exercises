class Game

  def initialize
    @board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    draw_board
    @moves = 0
  end

  def draw_board
    @rows = ['     |     |     ', '-----+-----+-----',
             "  #{@board[0][0]}  |  #{@board[0][1]}  |  #{@board[0][2]}  ",
             "  #{@board[1][0]}  |  #{@board[1][1]}  |  #{@board[1][2]}  ",
             "  #{@board[2][0]}  |  #{@board[2][1]}  |  #{@board[2][2]}  "]
    puts [@rows[0], @rows[2], @rows[0], @rows[1],
          @rows[0], @rows[3], @rows[0], @rows[1],
          @rows[0], @rows[4], @rows[0]]
  end

  def play_round(player, space)  # To do: check that move is valid
    @cell = space - 1
    @cell_x = (@cell / 3).floor
    @cell_y = @cell % 3
    @board[@cell_x][@cell_y] = player
    draw_board
    @moves += 1
    check_winner(player)
  end

  def check_winner(player)
    lines
    if @lines.include?([player, player, player])
      puts "Three in a row! #{player} wins!"
    elsif @moves == 9
      puts "Uh-oh! Cat's game!"
    end
  end

  def lines
    @diagonals = [[@board[0][0], @board[1][1], @board[2][2]], [@board[0][2], @board[1][1], @board[2][0]]]
    @lines = @board + @board.transpose + @diagonals
  end
end

game = Game.new
game.play_round("X", 4)
game.play_round("O", 5)
game.play_round("X", 1)
game.play_round("O", 7)
game.play_round("X", 3)
game.play_round("O", 2)
game.play_round("X", 8)
game.play_round("O", 9)
game.play_round("X", 6)
