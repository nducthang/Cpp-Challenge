#include <iostream>
#include <algorithm>
using namespace std;
typedef long long int ll;
#define MAX 1005
ll n,m, p[MAX], result = 0, price = 0;
int main()
{
    cin>>n>>m;
    for(int i=1;i<=m;i++) cin>>p[i];
    sort(p+1, p+m+1);
    for(int i=1; i <=m ;i++)
    {
        if(p[i] * min(n, m - i + 1)>result){
            result = p[i] * min(n, m - i + 1);
            price = p[i];
        }
    }
    cout << price << " " << result;
}