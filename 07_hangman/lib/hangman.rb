class Game
  def initialize
    @dictionary = File.open('dictionary.txt', 'r').readlines
    clean_dictionary
    @word = @dictionary[rand(@dictionary.length)].upcase
    @remaining_guesses = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    @blanks = '_' * @word.length
    get_indices(@word)
    player_guess
    process_guess
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
    puts 'yay' if @indices.include?(@guess)
  end
end

game = Game.new
game
