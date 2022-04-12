def bubble_sort(list)
  sorted = false

  while sorted == false do
    # Will remain true only if no numbers are swapped
    sorted = true
    list.each_with_index do |number, index|
      # Avoid nil comparisons by stopping at length-1
      unless index == list.length-1
        if list[index] > list[index+1]
          # At least one pair of numbers was unordered, so remain in the while loop
          sorted = false
          # Swap unordered pair
          list[index], list[index+1] = list[index+1], list[index]
        end
      end
    end
  end

  list
end

print(bubble_sort([4,3,78,2,0,2]), "\n")
# Expected output: [0,2,2,3,4,78]