#include <iostream>
#include <fstream>

using namespace std;
#define MAX 30002
int n;
int a[MAX], f[MAX];
int maxValue = INT32_MIN, start, endd, temp = 1;
int main()
{
    fstream in("./file/AMAX.INP", ios::in);
    in >> n;
    for (int i = 1; i <= n; i++)
    {
        in >> a[i];
        if (a[i] >= a[i - 1])
        {
            f[i] = f[i - 1] + a[i];
            if (f[i] > maxValue)
            {
                maxValue = f[i];
                endd = i;
                start = temp;
            }
        }
        else
        {
            f[i] = a[i];
            temp = i;
        }
    }
    in.close();
    cout << maxValue << " " << start << " " << endd;
}