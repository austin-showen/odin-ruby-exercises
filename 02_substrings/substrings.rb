def substrings(string, dictionary)
  string = string.downcase
  puts string
  result = dictionary.reduce(Hash.new(0)) do |hash, entry|
    hash[entry] += 1 if string.include?(entry)
    hash
  end
  puts result
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
substrings("below", dictionary)
# Expected output: { "below" => 1, "low" => 1 }

substrings("Howdy partner, sit down! How's it going?", dictionary)
# Expected output: { "down" => 1, "go" => 1, "going" => 1, "how" => 2, "howdy" => 1, "it" => 2, "i" => 3, "own" => 1, "part" => 1, "partner" => 1, "sit" => 1 }

# To do: correct logic to count multiple occurrences of substrings