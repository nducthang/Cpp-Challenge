#include <iostream>
using namespace std;
#define MAX 100002
long long l[4],c[4];
long long n;
long long s,f;
long long L[MAX]; // L[i] la do dai tu 1 den i
long long F[MAX]; // F[i]: do dai min tu s --> i (i>=s)
void Enter()
{
	cin>>l[1]>>l[2]>>l[3]>>c[1]>>c[2]>>c[3];
	cin>>n;
	cin>>s>>f;
	for(long long i=2;i<=n;i++)
		cin>>L[i];
}
void Optimize()
{
	F[s]=0;
	F[s+1]=(L[s+1]-L[s]<=l[1])?c[1]:(L[s+1]-L[s]>l[1] && L[s+1]-L[s]<=l[2])?c[2]:c[3];
	for(long long i=s+1;i<=f;i++)
	{
		F[i]=1000000000*(f-s);
		for(long long j=i-1;j>=s;j--)
		{
			if(L[i]-L[j]>l[3]) break;
			//F[i]=min(F[i],F[j]+(L[i]-L[j]<=l[1])?c[1]:(L[i]-L[j]>l[1] && L[i]-L[j]<=l[2])?c[2]:c[3]);
			for(long long k=1;k<=3;k++)
			{
				if(L[i]-L[j]<=l[k] && F[i]>F[j]+c[k])
				{
					F[i]=F[j]+c[k];
					break;
				}
			}
		}
	}
	
}
int main()
{
	Enter();
	Optimize();
	cout<<F[f]<<endl;
}
