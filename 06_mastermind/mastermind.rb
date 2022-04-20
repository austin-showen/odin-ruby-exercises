class Game
  def initialize(codemaker, codebreaker)
    @codemaker = codemaker
    @codebreaker = codebreaker
    @guesses = 1
    @code_length = 4
    @colors = %w[R O Y G B V]
    play
  end

  def play
    @code = @codemaker.generate_code(@code_length, @colors)
    12.times do
      @guess = @codebreaker.guess(@guesses)
      @score = @codemaker.evaluate_guess(@guess)
      p @score
      @guesses += 1
      break if @score[:exact] == 4
    end
  end
end

class ComputerCodemaker
  def initialize
    @code = ''
  end

  def generate_code(code_length, colors)
    code_length.times do
      @code += colors[rand(6)]
    end
    puts "Code: $#{@code}"
    @code
  end

  def evaluate_guess(guess)
    @guess = guess
    @temp_code = String.new(@code)
    @exact = 0
    @inexact = 0
    exact_matches
    inexact_matches
    { exact: @exact, inexact: @inexact }
  end

  def exact_matches
    @temp_code.each_char.with_index do |char, i|
      if char == @guess[i]
        @exact += 1
        @guess[i] = 'Z'
        @temp_code[i] = 'X'
      end
    end
  end

  def inexact_matches
    @temp_code.each_char.with_index do |char, i|
      if @guess.include? char
        @inexact += 1
        @guess.sub!(char, 'Z')
        @temp_code[i] = 'X'
      end
    end
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
    puts 'Please enter your guess as a series of four letters, such as RRGV.'
    puts 'The colors are (R)ed, (O)range, (Y)ellow, (G)reen, (B)lue, and (V)iolet.'
    guess = gets.chomp.upcase
    until valid?(guess)
      puts 'Invalid guess! Try again.'
      guess = gets.chomp.upcase
    end
    guess
  end

  def valid?(guess)
    return false unless guess.length == 4

    guess.each_char { |char| return false unless 'ROYGBV'.include?(char) }
    true
  end
end

codemaker = ComputerCodemaker.new
codebreaker = PlayerCodebreaker.new
Game.new(codemaker, codebreaker)
