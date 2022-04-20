class Game
  def initialize(codemaker, codebreaker, colors, code_length)
    @codemaker = codemaker
    @codebreaker = codebreaker
    @guesses = 1
    @colors = colors
    @code_length = code_length
    @max_turns = 12
    play
  end

  def play
    @code = @codemaker.generate_code
    @max_turns.times do
      @guess = @codebreaker.guess(@guesses)
      @score = @codemaker.evaluate_guess(@guess)
      p @score
      @guesses += 1
      break if @score[:exact] == @code_length
    end
  end
end

class ComputerCodemaker
  def initialize(colors, code_length)
    @colors = colors
    @code_length = code_length
    @code = ''
  end

  def generate_code
    @code_length.times do
      @code += @colors[rand(@colors.length)]
    end
    puts "Code: #{@code}"
    @code
  end

  def evaluate_guess(guess)
    return { exact: @code_length, inexact: 0 } if guess == @code

    @guess = guess
    @temp_code = String.new(@code)
    exact = exact_matches
    inexact = inexact_matches
    { exact: exact, inexact: inexact }
  end

  private

  def exact_matches
    matches = 0
    @temp_code.each_char.with_index do |char, i|
      if char == @guess[i]
        matches += 1
        @guess[i] = 'Z'
        @temp_code[i] = 'X'
      end
    end
    matches
  end

  def inexact_matches
    matches = 0
    @temp_code.each_char.with_index do |char, i|
      if @guess.include? char
        matches += 1
        @guess.sub!(char, 'Z')
        @temp_code[i] = 'X'
      end
    end
    matches
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
  def initialize(colors, code_length)
    @colors = colors
    @code_length = code_length
  end

  def guess(guesses)
    puts "Guess ##{guesses} out of 12"
    puts 'Please enter your guess as a series of four letters, such as RUBY. Repeating letters are allowed.'
    puts 'The colors are (R)ose, (U)mber, (B)eige, (Y)am, (C)hartreuse, and (H)oneydew.'
    guess = gets.chomp.upcase
    until valid?(guess)
      puts 'Invalid guess! Try again.'
      guess = gets.chomp.upcase
    end
    guess
  end

  private

  def valid?(guess)
    return false unless guess.length == @code_length

    guess.each_char { |char| return false unless @colors.include?(char) }
    true
  end
end

colors = %w[R U B Y C H]
code_length = 4

codemaker = ComputerCodemaker.new(colors, code_length)
codebreaker = PlayerCodebreaker.new(colors, code_length)
Game.new(codemaker, codebreaker, colors, code_length)
