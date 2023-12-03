#include <iostream>
#include <cstdlib>
#include <limits>
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
    cout<<"Range: "<<max<<" -> "<<min<<endl;

    int table[2][10];
    int temp[10];

    for(int i=0; i<10; i++)
    {
        temp[i]=0;
    }

    for (int i = 0; i < 2; ++i) {
        for (int j = 0; j < 10; ++j) {
            table[i][j] = 0;
            cout<<table[i][j];
        }
        cout<<endl;
    }

    int num=0;
    for(long long int x=min; x<=max; x++)
    {
        
        num= collatz(x);
        cout<<x<<" "<<num<<endl;
        
       
    }
    

    for (int i = 0; i < 2; ++i) {
        for (int j = 0; j < 10; ++j) {
            cout<<table[i][j];
        }
        cout<<endl;
    }
    
    
   

    




    return 0;
}

int collatz(long long int num)
{
    int counter=0;

    while(num>2)
    {
        if(num%2==0)
        {
            num=num/2;
        }
        if(num%2==1)
        {
            num=((3*num)+1)/2;
        }
        //cout<<num<<endl;
        counter++;

    }
    return counter;

}