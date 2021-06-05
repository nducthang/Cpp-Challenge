#include <iostream>
#include <cmath>
using namespace std;
#define MAX 10005
long long n,a[MAX];
int F[MAX]; //F[i] la do dai day con khong giam dai nhat tu 1 den i
int maxF=-1;
void Enter()
{
	cin>>n;
	for(int i=1;i<=n;i++)
		cin>>a[i];
	a[0]=-100000001;
	F[0]=0;
}
bool Check(long long x)
{
	int k=(-1+sqrt(1+8*x))/2;
	if(k*(k+1)==x*2)
		return true;
	return false;
}
int main()
{
	Enter();
	for(int i=1;i<=n;i++)
	{
		if(Check(a[i]))
		{
			if(a[i]>=a[i-1] && F[i-1]>-1)
			{
				F[i]=F[i-1]+1;
				if(F[i]>maxF) maxF=F[i];
			}
		}
		else
			F[i]=-1;
	}
	cout<<maxF+1;
}
