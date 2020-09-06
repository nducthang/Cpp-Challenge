#include <iostream>
#include <fstream>
using namespace std;
#define MAX 1000
int n;
int a[MAX];
int maxValue = -1;
int numOdd = 0, numEven = 0;
int main()
{
    fstream in("./file/INPUT.TXT", ios::in);
    in >> n;
    for (int i = 0; i < n; i++)
    {
        in >> a[i];
        if (a[i] > maxValue)
            maxValue = a[i];
        if (a[i] % 2 == 0)
            numOdd++;
        else
            numEven++;
    }
    // sort
    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < i; j++)
        {
            if (a[j] > a[i])
                swap(a[i], a[j]);
        }
    }
    // write file
    fstream out("./file/OUTPUT.TXT", ios::out);
    out << "Cau a: " << maxValue << endl;
    out << "Cau b: " << numOdd << " " << numEven << endl;
    out << "Cau c:\n";
    for (int i = 0; i < n; i++)
        out << a[i] << " ";
    in.close();
}