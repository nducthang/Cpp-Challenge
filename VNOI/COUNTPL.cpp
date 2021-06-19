#include <iostream>
#include <algorithm>
using namespace std;
string s;
bool dd[256][256];
int f[256]; // so luong it nhat palindrome co the tim dc tu 1 den i
int main()
{
    cin>>s;
    int n = s.length();
    s = ' ' + s;
    for(int i=1;i<=n;i++) dd[i][i] = true;
    for(int i=1;i<=n-1;i++)
        if(s[i]==s[i+1]) dd[i][i+1] = true;
    for(int len=3;len<=n;len++)
    {
        for(int i=1;i<=n-len+1;i++)
        {
            dd[i][i+len-1] = dd[i+1][i+len-2] && (s[i] == s[i+len-1]);
        }
    }
    for(int i=1;i<=n;i++) f[i] = 260;
    for(int i=1;i<=n;i++)
    {
        for(int j=0;j<=i-1;j++)
        {
            if(dd[j+1][i]) f[i] = min(f[i], f[j] + 1);
        }
    }
    cout<<f[n];
}