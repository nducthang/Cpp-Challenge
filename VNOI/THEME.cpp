#include <iostream>
using namespace std;
int maxValue = 1000000000;
int main()
{
    int n, a[5002];
    cin>>n;
    for(int i=1;i<=n;i++) cin>>a[i];
    int c;
    int res = 0;
    // duyet khoang cach giua 2 doan cao trao
    for(int i=5; i<=n-5;i++)
    {
        int tmp = maxValue;
        // Danh gia vi tri cua 2 doan cao trao
        // doan 1: j=1
        // doan 2: j=i+j
        for(int j=1;j<=n-i;j++)
        {
            if(a[i+j]-a[j]==tmp)
            {
                if(c==i) break;
                c++;
                res = max(res, c);
            }
            else
            {
                c = 1; tmp = a[i+j]-a[j];
            }
        }
    }
    if(res<5) cout<<0<<endl;
    else cout<<res<<endl;
}