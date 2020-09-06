#include <iostream>
#include <fstream>
#include <cmath>
using namespace std;
#define MAX 1000
int M, N;
int a[MAX][MAX];
int maxValue = -1;
int numOdd = 0, numEven = 0, numNT = 0;
bool checkNT(int n)
{
    if (n < 2)
        return 0;
    if (n == 2)
        return 1;
    for (int i = 2; i <= sqrt(n); i++)
        if (n % i == 0)
            return 0;
    return 1;
}
int main()
{
    fstream in("./file/INPUT_20.TXT", ios::in);
    in >> M >> N;
    for (int i = 0; i < M; i++)
    {
        for (int j = 0; j < N; j++)
        {
            in >> a[i][j];
            if (a[i][j] > maxValue)
            {
                maxValue = a[i][j];
            }
            if (a[i][j] % 2 == 0)
                numOdd++;
            else
                numEven++;
            if (checkNT(a[i][j]))
                numNT++;
        }
    }
    // write file
    fstream out("./file/OUTPUT_20.TXT", ios::out);
    out << "Cau a: " << maxValue << endl;
    out << "Cau b: " << numOdd << " " << numEven << " " << numNT << endl;
    out << "Cau c:\n";
    for (int i = 0; i < M; i++)
    {
        int sumRow = 0;
        for (int j = 0; j < N; j++)
            sumRow += a[i][j];
        out << sumRow << " ";
    }
    out.close();
    in.close();
}