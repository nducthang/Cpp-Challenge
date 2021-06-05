#include <iostream>
using namespace std;
#define MAX 10001
#define MAXF 30000
long n;
long p[MAX],k[MAX];
long F[MAXF]; 
void Enter()
{
	cin>>n;
	for(long i=1;i<=n;i++)
	{
		cin>>p[i]>>k[i];
	}
}
void QuickSort(long k[],long left,long right)
{
	long x,i,j;
	x=k[(left+right)/2];
	i=left;
	j=right;
	do
	{
		while(k[i]<x) i++;
		while(k[j]>x) j--;
		if(i<=j)
		{
			swap(k[i],k[j]);
			swap(p[i],p[j]);
			i++;
			j--;
		}
	}while(i<=j);
	if(left<j) QuickSort(k,left,j);
	if(right>i) QuickSort(k,i,right);
}
long Find_j(long k[],long p)
{
	for(long j=n;j>=1;j--)
	{
		if(k[j]<=p) return j;
	}
	return 0;
}
void Optimize()
{
	F[0]=0;
	for(long i=1;i<=MAXF;i++)
	{
		F[i]=max(F[i-1],k[i]-p[i]+F[Find_j(k,p[i])]);
	}
}
int main()
{
	Enter();
	QuickSort(k,1,n);
	Optimize();
	cout<<F[MAXF]<<endl;
}
