def substrings(string, dictionary)
  lower_string = string.downcase
  result = dictionary.reduce(Hash.new(0)) do |hash, word|
    matches = lower_string.scan(word)
    num_matches = matches.length
    hash[word] = matches.length if matches.length > 0
    hash
  end
  result
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
puts substrings("below", dictionary)
# Expected output: { "below" => 1, "low" => 1 }

puts substrings("Howdy partner, sit down! How's it going?", dictionary)
# Expected output: { "down" => 1, "go" => 1, "going" => 1, "how" => 2, "howdy" => 1, "it" => 2, "i" => 3, "own" => 1, "part" => 1, "partner" => 1, "sit" => 1 }

# To do: correct logic to count multiple occurrences of substrings