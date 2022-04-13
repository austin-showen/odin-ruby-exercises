def bubble_sort(list)
  sorted = false

  while sorted == false
    # Will remain true only if no numbers are swapped
    sorted = true
    list[0..-2].each_with_index do |_value, i|
      next if list[i] <= list[i + 1]

      # At least one pair of numbers was unordered, so swap them and remain in the while loop
      sorted = false
      list[i], list[i + 1] = list[i + 1], list[i]
    end
  end
  list
end

print(bubble_sort([4, 3, 78, 2, 0, 2]), "\n")
# Expected output: [0, 2, 2, 3, 4, 78]
