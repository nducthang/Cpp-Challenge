#include <iostream>
#include <algorithm>
using namespace std;
typedef long long ll;
#define MAX 10002
#define INF 1e9+2
ll n, k, a[MAX], F[MAX];
ll res = 0;

int main()
{
    cin >> n >> k;
    for (ll i = 1; i <= n; i++){
        cin >> a[i];
        F[i] = -INF;
    }

    for (ll i = 1; i <= n; i++)
    {
        for (ll j = i - 1; j >= 0 && j >= i - k; j--)
        {
            F[i] = max(F[i], F[j] + a[i]);
        }
        res = max(res, F[i]);
    }
    cout << res;
}