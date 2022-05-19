def clean_dictionary(dictionary)
  dictionary.each(&:chomp!)
  dictionary.select! { |word| word if word.length >= 5 && word.length <= 12 }
end

def word_indices(word)
  indices = {}
  word = word.split('')
  word.each_with_index do |char, i|
    if indices.include?(char)
      indices[char].push(i)
    else
      indices[char] = [i]
    end
  end
  indices
end

dictionary = File.open('dictionary.txt', 'r').readlines
dictionary = clean_dictionary(dictionary)
word = dictionary[rand(dictionary.length)]
puts word

indices = word_indices(word)
puts indices
