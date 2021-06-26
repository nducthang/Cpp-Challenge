#include <iostream>
#include <algorithm>
using namespace std;
#define MAX 100002
int n,x,y,a[MAX], b[MAX], res =0;
int main()
{
    cin>>n>>x>>y;
    for(int i=1;i<=n;i++) cin>>a[i]>>b[i];
    sort(a+1, a+n+1);
    sort(b+1, b+n+1);
    for(int i=1;i<=n;i++)
        if(a[i]>b[i]) res += y*(a[i]-b[i]);
        else res += x*(b[i]-a[i]);
    cout<<res<<endl;
}