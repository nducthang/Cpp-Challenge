#include <iostream>
#include <algorithm>
using namespace std;
#define MAX 17
#define MAXC 5001
int C,N;
long long w[MAX];
long long F[MAX][MAXC]; // F[i][j]= so cach chon tu 1 -> i sao cho khoi luong la <=j

void Enter()
{
	cin>>C>>N;
	for(int i=1;i<=N;i++)
		cin>>w[i];
}
void Cal()
{
	for(int i=1;i<=N;i++)
	{
		for(int j=0;j<=C;j++)
		{
			F[i][j]=max(F[i-1][j],(j>=w[i]?F[i-1][j-w[i]]+w[i]:0));
		}
	}
}
int main()
{
	Enter();
	Cal();
	cout<<F[N][C]<<endl;
}
