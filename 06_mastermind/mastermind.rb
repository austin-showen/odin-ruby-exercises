class Game
  def initialize(codemaker, codebreaker)
    @codemaker = codemaker
    @codebreaker = codebreaker
    @guesses = 1
    @code_length = 4
    @colors = ['R', 'O', 'Y', 'G', 'B', 'V']
    play
  end

  def play
    @code = @codemaker.generate_code(@code_length, @colors)
    @guess = @codebreaker.guess(@guesses)
    @score = @codemaker.evaluate_guess(@code, @guess)
    @guesses += 1
  end

end

class ComputerCodemaker
  def initialize
  end

  def generate_code(code_length, colors)
    @code = ""
    code_length.times do
      @code += colors[rand(6)]
    end
    puts "Code: $#{@code}"
    @code
  end

  def evaluate_guess(code, guess)
    @exact = 0
    @inexact = 0
    for i in (0..3) do
      if code[i] == guess[i]
        @exact += 1
        code[i], guess[i] = 'X', 'Z'
      end
    end
    for i in (0..3) do
      if guess.include? code[i]
        @inexact += 1
        guess.sub!(code[i], 'Z')
        code[i] = 'X'
      end
    end
    {exact: @exact, inexact: @inexact}
  end
end

class ComputerCodebreaker
end

class PlayerCodemaker
  def initialize
  end

  def generate_code
  end

  def evaluate_guess
  end
end

class PlayerCodebreaker
  def initialize
  end

  def guess(guesses)
    puts "Guess ##{guesses} out of 12"
    puts "Please enter your guess as a series of four letters, such as RRGV."
    puts "The colors are (R)ed, (O)range, (Y)ellow, (G)reen, (B)lue, and (V)iolet."
    guess = gets.chomp.upcase
    until valid?(guess)
      puts "Invalid guess! Try again."
      guess = gets.chomp.upcase
    end
    guess
  end

  def valid?(guess)
    return false unless guess.length == 4
    guess.each_char { |char| return false unless 'ROYGBV'.include?(char) }
    return true
  end
end

codemaker = ComputerCodemaker.new
codebreaker = PlayerCodebreaker.new
game = Game.new(codemaker, codebreaker)