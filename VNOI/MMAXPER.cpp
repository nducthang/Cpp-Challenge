#include <iostream>
#include <cmath>
#include <algorithm>
using namespace std;
#define MAX 1002
int n, x[MAX], y[MAX];
int f[MAX], g[MAX];
int main()
{
    cin>>n;
    for(int i=1;i<=n;i++) cin>>x[i]>>y[i];
    f[1] = x[1];
    g[1] = y[1];
    for(int i=2;i<=n;i++)
    {
        f[i] = max(f[i-1] + abs(y[i]-y[i-1]), g[i-1] +abs(y[i]-x[i-1])) + x[i];
        g[i] = max(f[i-1] + abs(x[i]-y[i-1]), g[i-1] + abs(x[i]-x[i-1])) + y[i];
    }
    cout<<max(f[n], g[n]);
}