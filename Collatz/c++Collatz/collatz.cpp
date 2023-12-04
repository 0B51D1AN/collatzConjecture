#include <iostream>
#include <cstdlib>
#include <limits>
#include <vector>
#include <algorithm>
using namespace std;

int collatz(long long int num);

int main(int argc, char *argv[])
{


    if(argc<3)
    {
        cout<<"Please provide a range (Smallest to Largest) to calculate the longest Collatz Sequences\n";
        return 1;
    }
    long long int min=atoi(argv[1]);

    long long int max=atoi(argv[2]);
    cout<<"Range: "<<min<<" -> "<<max<<endl;

    vector<pair<int, int>> sequenceLengths; 


    cout<<"\nSorted based on sequence length\n";
    for (int i = min; i <= max; ++i) 
    {
            int length = collatz(i);
            sequenceLengths.emplace_back(i, length);
    }

        // Sorting the vector based on sequence lengths
        sort(sequenceLengths.begin(), sequenceLengths.end(), [](const auto &a, const auto &b) {
            return a.second > b.second;
        });

        
        int count = 1;
            for(const auto &pair : sequenceLengths) 
            {
                cout <<"      " << pair.first << "          " << pair.second << endl;
                if (count == 10) 
                {
                    break;
                }
                ++count;
            }
 
        

    vector<int> top10Numbers;
    for (int i = 0; i < 10; ++i) {
        top10Numbers.push_back(sequenceLengths[i].first);
    }

    // Sort the top 10 numbers by their numerical value
    int size = top10Numbers.size();
    for (int i = 0; i < size - 1; ++i) {
        bool swapped = false;

        for (int j = 0; j < size - i - 1; ++j) {
            if (top10Numbers[j] > top10Numbers[j + 1]) {
                swap(top10Numbers[j], top10Numbers[j + 1]);
                swap(sequenceLengths[j],sequenceLengths[j+1]);
                swapped = true;
            }
        }

        // If no two elements were swapped in the inner loop, the array is already sorted
        if (!swapped) {
            break;
        }
    }

    cout << "\nSorted based on integer size\n";
    for (int i = 9; i >=0; --i) {
        cout<< "      " << top10Numbers[i] << "           " << sequenceLengths[i].second <<endl;
    }

    return 0;
}

int collatz(long long int n)
{
    int length = 1; // Initializing length as 1 since the number itself is included

    while (n != 1) {
        if (n % 2 == 0) {
            n = n / 2;
        } else {
            n = 3 * n + 1;
        }
        length++;
    }

    return length;

}