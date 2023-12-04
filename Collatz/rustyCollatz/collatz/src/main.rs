use std::env;

fn collatz(mut n: u64) -> u64 {
    let mut length = 1;

    while n != 1 {
        if n % 2 == 0 {
            n /= 2;
        } else {
            n = 3 * n + 1;
        }
        length += 1;
    }

    length
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

    let mut top_10_numbers: Vec<u64> = sequence_lengths.iter().take(10).map(|x| x.0).collect();
    top_10_numbers.sort();

    println!("\nSorted based on integer size");
    for i in (0..10).rev() {
        let index = sequence_lengths.iter().position(|&x| x.0 == top_10_numbers[i]).unwrap();
        println!("      {}           {}", sequence_lengths[index].0, sequence_lengths[index].1);
    }
}
