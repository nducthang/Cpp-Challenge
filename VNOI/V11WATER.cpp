#include <iostream>
#include <algorithm>
using namespace std;

int main()
{
    long n, h[100002];
    long l[100002], r[100002];
    long res = 0;
    cin>>n;
    for(int i=1;i<=n;i++) cin>>h[i];
    for(int i=1;i<=n;i++) l[i] = max(l[i-1], h[i]);
    for(int i=n;i>=1;i--) r[i] = max(r[i+1], h[i]);
    for(int i=1;i<=n;i++) res += min(l[i], r[i]) - h[i];
    cout<<res<<endl;
}