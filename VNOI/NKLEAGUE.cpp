#include <iostream>
using namespace std;
#define MAX 1005
char c[MAX][MAX];
int n;
bool dd[MAX];
int res[MAX];
int dem=0;
void Enter()
{
    cin>>n;
    for(int i=1;i<=n;i++)
        for(int j=1;j<=n;j++)
            cin>>c[i][j];
}
void Try(int i)
{
    dd[i] = true;
    for(int j=1;j<=n;j++){
        if(c[i][j]=='0' && !dd[j]){
            Try(j);
        }
    }
    res[++dem] = i;
}
int main()
{
    Enter();
    for(int i=1;i<=n;i++){
        if(!dd[i]) Try(i);
    }
    for(int i=1;i<=dem;i++) cout<<res[i]<< " ";
}