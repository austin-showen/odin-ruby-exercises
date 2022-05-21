class Game
  def initialize
    @remaining_guesses = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    @remaining_turns = 9
    @correct_letters = 0
    @incorrect_letters = ''
    @victory = false
    @defeat = false
    load_dictionary
    load_word
    first_round
  end

  def load_dictionary
    @dictionary = File.open('dictionary.txt', 'r').readlines
    @dictionary.each(&:chomp!)
    @dictionary.select! { |word| word if word.length >= 5 && word.length <= 12 }
  end

  def load_word
    @word = @dictionary[rand(@dictionary.length)].upcase
    @blanks = '_' * @word.length
    @indices = {}
    word = @word.split('')
    word.each_with_index do |char, i|
      @indices.include?(char) ? @indices[char].push(i) : @indices[char] = [i]
    end
  end

  def first_round
    puts <<~WELCOME
      Welcome to Hangman!
      You have #{@remaining_turns} chances to guess the letters in this #{@word.length}-letter word.
      You may enter a single letter or guess the entire word. Watch out! If you incorrectly guess the whole word,
      you will immediately lose!
      #{@blanks}
      Enter your first guess:
    WELCOME
    player_guess
    process_guess
    play_round until @victory == true || @defeat == true
  end

  def play_round
    puts <<~PROMPT
      #{@blanks}
      #{@correct_letters}/#{@word.length} letters guessed. #{@remaining_turns} mistakes remaining.
      Incorrect guesses: #{@incorrect_letters}
    PROMPT
    player_guess
    process_guess
    victory if @blanks == @word
    defeat if @remaining_turns.zero?
  end

  def player_guess
    @guess = ''
    @guess = gets.chomp.upcase until @guess.length == 1 && @remaining_guesses.include?(@guess)
  end

  def process_guess
    @remaining_guesses.delete!(@guess)
    unless @indices.include?(@guess)
      @remaining_turns -= 1
      @incorrect_letters += @guess
      return
    end
    @indices[@guess].each do |index|
      @blanks[index] = @guess
      @correct_letters += 1
    end
  end

  def victory
    @victory = true
    puts "You win! The word was #{@word}."
  end

  def defeat
    @defeat = true
    puts "You lose! The word was #{@word}."
  end
end

game = Game.new
game
