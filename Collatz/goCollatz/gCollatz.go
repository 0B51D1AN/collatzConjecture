package main

import (
	"fmt"
	"os"
	"strconv"
	"sort"
)

func collatz(n int64) int {
	length := 1 // Initializing length as 1 since the number itself is included

	for n != 1 {
		if n%2 == 0 {
			n = n / 2
		} else {
			n = 3*n + 1
		}
		length++
	}

	return length
}

func main() {
	args := os.Args
	if len(args) < 3 {
		fmt.Println("Please provide a range (Smallest to Largest) to calculate the longest Collatz Sequences")
		return
	}

	min, err := strconv.ParseInt(args[1], 10, 64)
	if err != nil {
		fmt.Println("Invalid minimum range")
		return
	}

	max, err := strconv.ParseInt(args[2], 10, 64)
	if err != nil {
		fmt.Println("Invalid maximum range")
		return
	}

	fmt.Println("Range:", min, "->", max)

	var sequenceLengths []struct{ first, second int }

	fmt.Println("\nSorted based on sequence length")
	for i := min; i <= max; i++ {
		length := collatz(i)
		sequenceLengths = append(sequenceLengths, struct{ first, second int }{int(i), length})
	}

	// Sorting the slice based on sequence lengths
	sort.Slice(sequenceLengths, func(i, j int) bool {
		return sequenceLengths[i].second > sequenceLengths[j].second
	})

	count := 1
	for _, pair := range sequenceLengths {
		fmt.Printf("      %d          %d\n", pair.first, pair.second)
		if count == 10 {
			break
		}
		count++
	}

	var top10Numbers []int
	for i := 0; i < 10; i++ {
		top10Numbers = append(top10Numbers, sequenceLengths[i].first)
	}

	// Sort the top 10 numbers by their numerical value
	size := len(top10Numbers)
	for i := 0; i < size-1; i++ {
		swapped := false

		for j := 0; j < size-i-1; j++ {
			if top10Numbers[j] > top10Numbers[j+1] {
				top10Numbers[j], top10Numbers[j+1] = top10Numbers[j+1], top10Numbers[j]
				sequenceLengths[j], sequenceLengths[j+1] = sequenceLengths[j+1], sequenceLengths[j]
				swapped = true
			}
		}

		// If no two elements were swapped in the inner loop, the slice is already sorted
		if !swapped {
			break
		}
	}

	fmt.Println("\nSorted based on integer size")
	for i := 9; i >= 0; i-- {
		fmt.Printf("      %d           %d\n", top10Numbers[i], sequenceLengths[i].second)
	}
}