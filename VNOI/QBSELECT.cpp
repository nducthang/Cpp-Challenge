#include <iostream>
#include <algorithm>
using namespace std;
#define MAX 10005
long n,a[MAX][MAX];
int x=0; //Trang thai
long F[MAX][16]; // F[i,x] la trong luong lon nhat den cot i, cot i co trang thai x
int d[]={0,1,2,4,5,8,9,10};
void Enter()
{
	// Nhap du lieu
	cin>>n;
	for(int i=1;i<=4;i++)
		for(int j=1;j<=n;j++)
			cin>>a[i][j];
}
int GetBit(int x,int k)
{
	// Lay bit thu k cua x
	return (x>>k-1)&1;
}
long Sum(int i,int x)
{
	// Tinh trong luong cot thu i voi trang thai x
	return GetBit(x,1)*a[1][i]+GetBit(x,2)*a[2][i]+GetBit(x,3)*a[3][i]+GetBit(x,4)*a[4][i];
}
bool Check(int x,int t)
{
	// Kiem tra xem x va t co bi trung bit nao khong
	for(int i=1;i<=4;i++)
	{
		if( GetBit(x,i)==1 && GetBit(t,i)==1 )
			return false;
	}
	return true;
}
void Optimize()
{
	// Quy hoach dong trang thai
	for(int i=1;i<=n;i++)
	{
		for(int j=0;j<=7;j++)
		{
			long sum=Sum(i,d[j]);
			for(int t=0;t<=7;t++)
			{
				if(Check(d[j],d[t]))
				{
					F[i][d[j]]=max(F[i][d[j]],F[i-1][d[t]]+sum);
				}
			}
		}
	}
}
int main()
{
	Enter();
	Optimize();
	long res=0;
	for(int x=0;x<=7;x++)
		res=max(res,F[n][d[x]]);
	cout<<res;
}
