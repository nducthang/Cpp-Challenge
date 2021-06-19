#include <iostream>
using namespace std;
#define MAX 222
int m, n;
int a[MAX][MAX];
int res[MAX];
char c;
int main()
{
    cin>>m>>n;
    for(int i=1;i<=m;i++)
    {
        for(int j=1;j<=n;j++)
        {
            cin>>c;
            if(c=='1') a[i][j] = 1;
            else a[i][j] = 0;
        }
    }
    for(int i=1;i<=n;i++) a[m+1][i] = 1;
    for(int j=1;j<=n;j++)
    {
        int i=1;
        while (i<=m)
        {
            while(i<=m && a[i][j] == 1) i++;
            if(i>m) break;
            int k=i+1;
            while(a[k][j]==0) k++;
            res[k-i]++;
            i = k;
        }
        
    }
    for(int i=1;i<=m;i++)
    {
        if(res[i]>0) cout<<i<<" "<<res[i]<<endl;
    }
}