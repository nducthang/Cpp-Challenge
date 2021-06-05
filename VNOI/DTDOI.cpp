#include<bits/stdc++.h>
using namespace std;
int n,s;
int a[101];
int d[100001];
int main()
{
	// Input data
	cin>>n>>s;
	for (int i=1; i <= n; i++)
		cin>>a[i];
	
	int mx=0; // mx= max(a[i]) voi i=1..n
    for (int i=1; i <= n; i++)
        mx=max(mx,a[i]);
	int res=0; // ket qua
	// tham lam de giam s
	while (s >= 100001)
	{
		res++;
		s-=mx;
	}
	// Quy hoach dong
	d[0]=0;
	for (int i=1; i <= s; i++)
	{
        d[i]=10000000;
        for (int j=1; j <= n; j++)
			if(i >= a[j])
				d[i]=min(d[i],d[i-a[j]]+1);
    }
	cout<<res+d[s];
}
