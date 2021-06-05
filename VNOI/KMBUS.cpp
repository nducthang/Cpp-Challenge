#include <iostream>
#include <algorithm>
using namespace std;
long B,C[101],L;
long F[10001];
void Enter()
{
	cin>>B>>L;
	for(long i=1;i<=B;i++)
		cin>>C[i];
}
void Optimize()
{
	F[0]=0;
	for(long i=1;i<=L;i++)
	{
		F[i]=10000;
		for(long j=i-1;j>=0;j--)
		{
			if(i-j>B) break;
			F[i]=min(F[i],F[j]+C[i-j]);
		}
	}
}
int main()
{
	Enter();
	Optimize();
	cout<<F[L]<<endl;	
}
