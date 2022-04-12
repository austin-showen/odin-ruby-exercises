def substrings(word, dictionary)
  result = dictionary.reduce(Hash.new(0)) do |hash, entry|
    hash[entry] += 1 if word.include?(entry)
    hash
  end
  puts result
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
substrings("below", dictionary)
# Expected output: { "below" => 1, "low" => 1 }