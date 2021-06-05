#include <iostream>
#include <vector>
using namespace std;
typedef long long ll;
#define MAX 100
#define E 2012
ll n, x, p;
ll d[MAX], c[MAX];
ll dem = 0;
// ll a[MAX][MAX], b[MAX][MAX];
vector<vector<ll>> a(MAX, vector<ll>(MAX, 0));
void InitListEdge()
{
    // Khoi tao danh sach canh
    ll j;
    for(ll i=1;i<=n-1;i++)
    {
        dem++;
        j = i + 1;
        d[dem] = i;
        c[dem] = j;
        dem++;
        d[dem] = j;
        c[dem] = i;
    }
    dem++;
    d[dem] = n;
    c[dem] = 1;
    dem++;
    d[dem] = 1;
    c[dem] = n;

    for(ll i=n+1;i<=2*n-1;i++)
    {
        j=i+1;
        dem++;
        d[dem] = i;
        c[dem] = j;
        dem++;
        d[dem] = j;
        c[dem] = i;
    }
    dem++;
    d[dem] = 2*n;
    c[dem] = n+1;
    dem++;
    d[dem] = n+1;
    c[dem] = 2*n;

    for(ll i=1;i<=n;i++)
    {
        j=i+n;
        dem++;
        d[dem] = i;
        c[dem] = j;
        dem++;
        d[dem] = j;
        c[dem] = i;
    }
}
void InitMatrix()
{
    for(ll i=1;i<=dem;i++)
        for(ll j=1;j<=dem;j++)
            if(c[i]==d[j] && c[j] == d[i]) a[i][j]=1;
}
vector<vector<ll>> Mul(vector<vector<ll>> p1, vector<vector<ll>> p2)
{
    // nhan ma tran p1 voi p2
    vector<vector<ll>> p(MAX, vector<ll>(MAX, 0));
    for(ll i=1;i<=dem;i++)
    {
        for(ll j=1;j<=dem;j++)
        {
            for(ll k=1;k<=dem;k++)
            {
                p[i][j] = (p[i][j]+p1[i][k]*p2[k][j]) % E;
            }
        }
    }
    return p;
}
vector<vector<ll>> Mu(ll i)
{
    if(i==1) return a;
    if(i%2==0)
    {
        vector<vector<ll>> tg = Mu(i/2);
        return Mul(tg, tg);
    }
    else
    {
        vector<vector<ll>> tg = Mu(i/2);
        return Mul(Mul(tg, tg), a);
    }
}
void Process()
{
    if(p==1)
    {
        for(ll i=1;i<=dem;i++)
        {
            if(d[i]==1 && c[i]==x)
            {
                cout<<1;
                return;
            }
        }
        cout<<0;
        return;
    }
    else
    {
        // Khoi tao ma tran
        InitMatrix();
        // xu ly
        vector<vector<ll>> kq;
        kq = Mu(p-2);
        kq = Mu(p-1);
        ll res = 0;
        for(ll i=1;i<=dem;i++)
            for(ll j=1;j<=dem;j++)
                if(d[i]==1 && c[j]==x)
                    res = (res+kq[i][j]) % E;
        cout<<res;
        return;
    }
}
int main()
{
    cin>>n>>x>>p;
    InitListEdge();
    Process();
}