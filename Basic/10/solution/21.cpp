#include <iostream>
#include <fstream>
#include <algorithm>
using namespace std;
#define MAX 30002
int n, a[MAX], f[MAX];
int maxSum = -INT32_MAX, start = 0, endd = 0;
int f_min = INT32_MAX;
int main()
{
    fstream in("./file/SUMMAX.INP", ios::in);
    in >> n;
    for (int i = 1; i <= n; i++)
    {
        in >> a[i];
        f[i] = f[i - 1] + a[i];
        // f_min = min(f_min, f[i]);
        if (f_min > f[i])
        {
            f_min = f[i];
            start = i + 1;
        }
        // maxSum = max(maxSum, f[i] - f_min);
        if(maxSum<f[i]-f_min)
        {
            maxSum = f[i] - f_min;
            endd = i;
        }
    }
    fstream out("./file/SUMMAX.OUT", ios::out);
    out << maxSum << " " << start << " " << endd;
    in.close();
    out.close();
}
