def caesar_cipher(string, shift)
  newString = ""
  shift %= 26
  string.each_char do |char|
    ascii = char.ord
    if ascii.between?(65, 90 - shift) or ascii.between?(97, 122 - shift)
      ascii += shift
    elsif ascii.between?(90 - shift, 90) or ascii.between?(122 - shift, 122)
      ascii = ascii + shift - 26
    end
    newString << ascii.chr
  end
  newString
end

puts caesar_cipher("What a string!", 31)