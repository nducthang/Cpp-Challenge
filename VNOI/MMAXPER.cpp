#include <iostream>
#include <cmath>
using namespace std;
#define MAX 1001
int n,a[MAX],b[MAX],f[MAX],g[MAX];
/*
n la so hinh chu nhat
a[i] la chieu rong hinh chu nhat i
b[i] la chieu dai hinh chu nhat i
f[i] la truong hop hcn i nam ngang
g[i] la truong hop hcn i nam thang dung
*/

int main()
{
	cin>>n;
	for(int i=1;i<=n;i++)
		cin>>a[i]>>b[i];
	f[1]=b[1];
	g[1]=a[1];
	for(int i=2;i<=n;i++)
	{
		f[i]=max(f[i-1]+b[i]+abs(a[i-1]-a[i]),g[i-1]+b[i]+abs(b[i-1]-a[i]));
		g[i]=max(g[i-1]+a[i]+abs(b[i-1]-b[i]),f[i-1]+a[i]+abs(a[i-1]-b[i]));
	}
	cout<<max(f[n],g[n])<<endl;	
}
