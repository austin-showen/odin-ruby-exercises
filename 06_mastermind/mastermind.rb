# Main controller class that runs a player versus computer game of Mastermind
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
      report_score if @codebreaker.instance_of?(PlayerCodebreaker)
    end
  end

  def report_score
    if @score[:exact] == @code_length
      puts "Congratulations! #{@guess} is the correct code!"
      exit
    end
    puts "#{@guess}: #{@score[:exact]} exact matches, #{@score[:inexact]} inexact matches.\n\n"
    @guesses += 1
    puts "Sorry! You're out of guesses." if @guesses > @max_turns
  end
end

# Generates a random code and evaluates the player's guesses
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
    @code
  end

  def evaluate_guess(guess)
    return { exact: @code_length, inexact: 0 } if guess == @code

    @temp_guess = guess.clone
    @temp_code = @code.clone
    exact = exact_matches
    inexact = inexact_matches
    { exact: exact, inexact: inexact }
  end

  private

  def exact_matches
    matches = 0
    @temp_code.each_char.with_index do |char, i|
      if char == @temp_guess[i]
        matches += 1
        @temp_guess[i] = 'Z'
        @temp_code[i] = 'X'
      end
    end
    matches
  end

  def inexact_matches
    matches = 0
    @temp_code.each_char.with_index do |char, i|
      if @temp_guess.include? char
        matches += 1
        @temp_guess.sub!(char, 'Z')
        @temp_code[i] = 'X'
      end
    end
    matches
  end
end

# Accepts guesses from the computer
class ComputerCodebreaker
  def initialize(colors, code_length)
    @colors = colors
    @code_length = code_length
    @possible_guesses = possible_guesses
  end

  def guess(_guesses)
    @possible_guesses.pop
  end

  def possible_guesses
    @num_guesses = @colors.length**@code_length
    @possible_guesses = []
    @colors.repeated_permutation(4) { |permutation| @possible_guesses.push(permutation) }
    @possible_guesses.map!(&:join)
    @possible_guesses
  end
end

# Accepts a code from the player's input and allows the player to evaluate the computer's guesses
class PlayerCodemaker
  def initialize(colors, code_length)
    @colors = colors
    @code_length = code_length
    @guesses = 1
  end

  def generate_code
    puts 'Please enter a four-character code for the computer to guess. Each character represents a color.'
    puts 'The colors are (R)ose, (U)mber, (B)eige, (Y)am, (C)hartreuse, and (H)oneydew.'
    code = gets.chomp.upcase
    until valid?(code)
      puts 'Invalid code! Enter your code as a series of four letters, such as RUBY. Repeating letters are allowed.'
      code = gets.chomp.upcase
    end
    code
  end

  def evaluate_guess(guess)
    puts "Computer guess ##{guesses}: #{guess}."
    puts 'How many exact matches are there? (Right color, right position.)'
    exact = gets.chomp.to_i until exact.instance_of?(Integer) && (0..@code_length).include?(exact)
    puts 'How many inexact matches are there? (Right color, wrong position.)'
    inexact = gets.chomp.to_i until inexact.instance_of?(Integer) && (0..@code_length).include?(inexact)
    { exact: exact, inexact: inexact }
  end

  private

  def valid?(code)
    return false unless code.length == @code_length

    code.each_char { |char| return false unless @colors.include?(char) }
    true
  end
end

# Accepts guesses from the player
class PlayerCodebreaker
  def initialize(colors, code_length)
    @colors = colors
    @code_length = code_length
  end

  def guess(guesses)
    if guesses == 1
      puts 'Please enter your guess as a series of four letters, such as RUBY. Repeating letters are allowed.'
      puts 'The colors are (R)ose, (U)mber, (B)eige, (Y)am, (C)hartreuse, and (H)oneydew.'
    end
    print "Guess ##{guesses} out of 12: "
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
codemaker = PlayerCodemaker.new(colors, code_length)
#codemaker = ComputerCodemaker.new(colors, code_length)
codebreaker = ComputerCodebreaker.new(colors, code_length)
#codebreaker = PlayerCodebreaker.new(colors, code_length)
Game.new(codemaker, codebreaker, colors, code_length)
