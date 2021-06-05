#include <iostream>
using namespace std;

long long C(long long n,long long k)
{
	long long res = 1;
	for(long long i=1;i<=k;++i,n--)
		res=res*n/i;
	return res;
}
int main()
{
	long long n,m,temp;
	long long F=0;
	cin>>n>>m;
	for(long long i=1;i<=n;++i)
	{
		cin>>temp;
		F=F+temp;
	}
	long long T=F-m;
	long long res = C(n+T-1,T);
	cout<< (res % 100003)<<endl;
}
