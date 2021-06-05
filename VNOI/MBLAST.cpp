#include <iostream>
#include <string>
#include <cmath>
using namespace std;
#define MAX 2002
string a,b;
int K;
int F[MAX][MAX];
int main()
{
	cin>>a>>b>>K;
	int n=a.length();
	int m=b.length();
	for(int i = 1; i <= n; ++i) F[i][0] = K * i;
    for(int j = 1; j <= m; ++j) F[0][j] = K * j;
    
	for(int i=1;i<=n;++i)
	{
		for(int j=1;j<=m;++j)
		{
			F[i][j]=min(min(F[i-1][j-1]+abs((int)a[i-1]-(int)b[j-1]),F[i-1][j-1]+2*K),min(F[i-1][j]+K,F[i][j-1]+K));
		}
	}
	cout<<F[n][m];
}
