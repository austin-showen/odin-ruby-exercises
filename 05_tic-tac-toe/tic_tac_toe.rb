class Game
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    @moves = 0
    draw_board
    coin_flip
  end

  def draw_board
    @rows = ['     |     |     ', '-----+-----+-----',
             "  #{@board[0][0]}  |  #{@board[0][1]}  |  #{@board[0][2]}  ",
             "  #{@board[1][0]}  |  #{@board[1][1]}  |  #{@board[1][2]}  ",
             "  #{@board[2][0]}  |  #{@board[2][1]}  |  #{@board[2][2]}  "]
    puts [@rows[0], @rows[2], @rows[0], @rows[1],
          @rows[0], @rows[3], @rows[0], @rows[1],
          @rows[0], @rows[4], @rows[0], '']
  end

  def coin_flip
    @current_player = rand(2) == 1 ? @player1 : @player2
    @other_player = @current_player == @player1 ? @player2 : @player1
    puts "Player #{@current_player.order} wins the coin flip!"
    move
  end

  def move
    puts "Player #{@current_player.order}, where will you place your #{@current_player.token}?"
    space = gets.chomp.to_i until (1..9).include?(space)
    cell(space)
    if @board[@cell_x][@cell_y].instance_of?(Integer)
      play_round
    else
      puts 'That spot is already taken!'
      move
    end
  end

  def play_round
    @board[@cell_x][@cell_y] = @current_player.token
    draw_board
    @moves += 1
    check_winner
    switch_player
    move
  end

  def switch_player
    @current_player, @other_player = @other_player, @current_player
  end

  def cell(space)
    @cell = space - 1
    @cell_x = (@cell / 3).floor
    @cell_y = @cell % 3
  end

  def check_winner
    lines
    if @lines.include?(Array.new(3, @current_player.token))
      puts "Three in a row! Player #{@current_player.order} wins!"
      @current_player.add_point
      play_again
    elsif @moves == 9
      puts "Uh-oh! Cat's game!"
      play_again
    end
  end

  def play_again
    puts 'Current scores:'
    puts "Player 1: #{@player1.score}     Player 2: #{@player2.score}"
    puts 'Play again? (Y/N)'
    response = gets.chomp.upcase until %w[Y N].include? response
    if response == 'Y'
      Game.new(@player1, @player2)
    else
      exit
    end
  end

  def lines
    @diagonals = [[@board[0][0], @board[1][1], @board[2][2]], [@board[0][2], @board[1][1], @board[2][0]]]
    @lines = @board + @board.transpose + @diagonals
  end
end

class Player
  attr_reader :score, :order
  attr_accessor :token

  def initialize(token, order)
    @order = order
    @token = token
    @score = 0
  end

  def add_point
    @score += 1
  end
end

puts 'Player 1, do you choose X or O?'
player1_choice = gets.chomp.upcase until %w[X O].include?(player1_choice)
player2_choice = player1_choice == 'O' ? 'X' : 'O'
puts "Player 1 is #{player1_choice}. Player 2 is #{player2_choice}."

player1 = Player.new(player1_choice, 1)
player2 = Player.new(player2_choice, 2)

Game.new(player1, player2)
