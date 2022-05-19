class Game
  def initialize
    @dictionary = File.open('dictionary.txt', 'r').readlines
    clean_dictionary
    @word = @dictionary[rand(@dictionary.length)].upcase
    @remaining_guesses = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    @remaining_turns = 9
    @blanks = '_' * @word.length
    get_indices(@word)
    @victory = false
    @defeat = false
    @correct_letters = 0
    play_round until @victory == true || @defeat == true
  end

  def play_round
    puts @blanks
    puts "#{@word.length} letters. #{@remaining_turns} mistakes remaining."
    player_guess
    process_guess
    @victory = true if @blanks == @word
    @defeat = true if @remaining_turns.zero?
  end

  def clean_dictionary
    @dictionary.each(&:chomp!)
    @dictionary.select! { |word| word if word.length >= 5 && word.length <= 12 }
  end

  def get_indices(word)
    @indices = {}
    word = word.split('')
    word.each_with_index do |char, i|
      @indices.include?(char) ? @indices[char].push(i) : @indices[char] = [i]
    end
  end

  def player_guess
    @guess = ''
    @guess = gets.chomp.upcase until @guess.length == 1 && @remaining_guesses.include?(@guess)
  end

  def process_guess
    @remaining_guesses.delete(@guess)
    unless @indices.include?(@guess)
      @remaining_turns -= 1
      return
    end
    @indices[@guess].each do |index|
      @blanks[index] = @guess
      @correct_letters += 1
    end
  end
end

game = Game.new
game
