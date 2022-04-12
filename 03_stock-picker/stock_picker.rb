def stock_picker(prices)
  # Nested array will store indices and values for each profitable pair
  possible_pairs = []

  prices.each_with_index do |buy_value, buy_index|
    prices.each_with_index do |sell_value, sell_index|
      if buy_value < sell_value and buy_index < sell_index
        possible_pairs << [buy_index, sell_index, buy_value, sell_value]
      end
    end
  end

  # Maps sell_value minus buy_value of each pair to a new array
  profits = possible_pairs.map { |pair| pair[3] - pair[2] }
  best_index = profits.index(profits.max)
  best_pair = possible_pairs[best_index]

  # Returns the subarray of [buy_index, sell_index] for the most profitable pair
  result = best_pair[0..1]
  result
end

print(stock_picker([17,3,6,9,15,8,6,1,10]), "\n")
# Expected output: [1, 4]