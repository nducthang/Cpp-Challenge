#include <iostream>
using namespace std;
#define MAX 50005
long long n,p,a[MAX];
bool D[MAX]; // D[i]=true <=> i la vi tri lam cho trong luong 1 day giam so voi vi truoc no
long long F[MAX]; // F[i] = sum(1->i) a[i]
void Enter()
{
	F[0]=0;
	D[0]=false;
	cin>>n>>p;
	for(int i=1;i<=n;i++)
	{
		cin>>a[i];
		F[i]=F[i-1]+a[i];
	}
}
void O_D()
{
	int min=0;
	for(int i=1;i<=n;i++)
	{
		if(F[i]<min)
		{
			min=F[i];
			D[i]=true;
		}
	}
}
void Result()
{
	int max_length=-1;
	int pos=n;
	for(int i=n;i>=0;--i)
	{
		if(D[i])
		{
			for(int j=pos;j>=i+1;--j)
			{
				if(F[j]-F[i]>=p)
				{
					if(j-i>max_length)
						max_length=j-i;
				}
				pos=j;
			}
		}
	}
	cout<<max_length;
}
int main()
{
	Enter();
	O_D();
	Result();
}
