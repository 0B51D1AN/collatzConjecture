use std::env;

fn collatz(mut n: u64) -> u64 {
    if n == 1 {
        1 // Base case: sequence length for 1 is 1
    } else if n % 2 == 0 {
        1 + collatz(n / 2) // If even, divide by 2
    } else {
        1 + collatz(3 * n + 1) // If odd, perform 3n + 1
    }
}

fn main() {
    let args: Vec<String> = env::args().collect();

    if args.len() < 3 {
        println!("Please provide a range (Smallest to Largest) to calculate the longest Collatz Sequences");
        return;
    }

    let min: u64 = args[1].parse().expect("Invalid input");
    let max: u64 = args[2].parse().expect("Invalid input");
    println!("Range: {} -> {}", min, max);

    let mut sequence_lengths: Vec<(u64, u64)> = Vec::new();

    println!("\nSorted based on sequence length");
    for i in min..=max {
        let length = collatz(i);
        sequence_lengths.push((i, length));
    }

    sequence_lengths.sort_by(|a, b| b.1.cmp(&a.1));

    let mut count = 1;
    for pair in sequence_lengths.iter() {
        println!("      {}          {}", pair.0, pair.1);
        if count == 10 {
            break;
        }
        count += 1;
    }

    let mut index = 0;
    while index < 9 {
        let mut swapped = false;

        let mut j = 0;
        while j < 9 - index {
            if sequence_lengths[j].0 > sequence_lengths[j + 1].0 {
                sequence_lengths.swap(j, j + 1);
                swapped = true;
            }
            j += 1;
        }

        if !swapped {
            break;
        }
        index += 1;
    }

    println!("\nSorted based on integer size");
    for i in (0..10).rev() {
        println!("      {}           {}", sequence_lengths[i].0, sequence_lengths[i].1);
    }
}