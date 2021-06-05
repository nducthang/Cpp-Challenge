#include <iostream>
#define MAX 1005
int m,n,a[MAX],b[MAX],F[MAX][MAX];
using namespace std;

int main()
{
	// Input data
	cin>>m>>n;
	for(int i=2;i<=m+1;i++) cin>>a[i];
	for(int i=2;i<=n+1;i++) cin>>b[i];
	// Process
	/*
	Goi F[i,j] la do dai day con chung khong lien ke dai nhat gom i so dau day A va j so dau day B
	Truong hop 1: a[i]=b[j] --> Do day con KHONG LIEN KE nen xet doan con lai la i-2 so dau day A va j-2 so dau day B
	F[i,j]=F[i-2,j-2]+1
	Truong hop 2: a[i]!=b[j] --> F[i,j]=max(F[i-1,j],F[i,j-1],F[i-1,j-1])
	*/
	for(int i=2;i<=m+1;i++)
	{
		for(int j=2;j<=n+1;j++)
		{
			F[i][j]=(a[i]==b[j])?F[i-2][j-2]+1:max(max(F[i-1][j],F[i][j-1]),F[i-1][j-1]);
		}
	}
	cout<<F[m+1][n+1];
}
