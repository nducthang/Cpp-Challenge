#include <iostream>
#include <fstream>
#include <cmath>
using namespace std;
#define MAX 1000
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
    fstream in("./file/NT.INP", ios::in);
    fstream out("./file/NT.OUT", ios::out);
    int n, temp, soNT = 0;
    int a[MAX];
    in >> n;
    for (int i = 0; i < n; i++)
    {
        in >> temp;
        if (checkNT(temp))
        {
            a[soNT++] = temp;
        }
    }
    // write file
    out << soNT << endl;
    for (int i = 0; i < soNT; i++)
        out << a[i] << " ";
}