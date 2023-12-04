function collatz(n)
    length = 1  # Initializing length as 1 since the number itself is included

    while n != 1
        if n % 2 == 0
            n = div(n, 2)
        else
            n = 3 * n + 1
        end
        length += 1
    end

    return length
end

function main(args)
    if length(args) < 2
        println("Please provide a range (Smallest to Largest) to calculate the longest Collatz Sequences")
        return 1
    end

    min = parse(Int, args[1])
    max = parse(Int, args[2])
    println("Range: $min -> $max")

    sequenceLengths = Tuple{Int, Int}[]

    println("\nSorted based on sequence length")
    for i in min:max
        length = collatz(i)
        push!(sequenceLengths, (i, length))
    end

    # Sorting the vector based on sequence lengths
    sort!(sequenceLengths, by = x -> x[2], rev = true)

    count = 1
    for pair in sequenceLengths
        println("      ", pair[1], "          ", pair[2])
        if count == 10
            break
        end
        count += 1
    end

    top10Numbers = [sequenceLengths[i][1] for i in 1:10]

    # Sort the top 10 numbers by their numerical value
    for i in 1:9
        swapped = false

        for j in 1:(10 - i)
            if top10Numbers[j] > top10Numbers[j + 1]
                top10Numbers[j], top10Numbers[j + 1] = top10Numbers[j + 1], top10Numbers[j]
                sequenceLengths[j], sequenceLengths[j + 1] = sequenceLengths[j + 1], sequenceLengths[j]
                swapped = true
            end
        end

        # If no two elements were swapped in the inner loop, the array is already sorted
        if !swapped
            break
        end
    end

    println("\nSorted based on integer size")
    for i in 10:-1:1
        println("      ", top10Numbers[i], "           ", sequenceLengths[i][2])
    end

    return 0
end

args = ARGS
exit(main(args))