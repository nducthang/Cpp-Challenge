#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
using namespace std;
typedef long long ll;
ll f[35][35];
ll n, k;
int lo;
ll res = 0;

int get_bit(const int state, const int pos)
{
    return (state >> pos) & 1;
}

int logg(ll x)
{
    // Đếm số bit nhị phân có nghĩa của 1 số
    int ans = 0;
    for (; x > 0; x /= 2) ans++;
    return ans;
}

void init()
{
    for (int i = 0; i < 35; i++) f[i][i] = f[0][i] = 1;
    for (int i = 1; i < 35; i++)
        for (int j = 1; j < 35; j++)
            if (!f[i][j])
                f[i][j] = f[i - 1][j - 1] + f[i][j - 1];
}
void solve()
{
    res = 0;
    lo = logg(n);
    // Nếu k lớn hơn số bit nhị phân có nghĩa của n thì ko tìm được phương án
    if (k > lo)
    {
        cout << 0 << "\n"; return;
    }

    for (int i = 1; i < lo; i++)
        if (i - k - 1 >= 0)
            res += f[i - k - 1][i - 1];

    int m = 0;
    int cnt = 0;
    // Xem n có bao nhiêu bit 0
    for (int i = 0; i < lo; i++) if (!get_bit(n, i)) cnt++;
    if (cnt == k) res++;
    for (int i = 0; i < lo - 1; i++)
        if (get_bit(n, i))
        {
            int remain = k - cnt - 1;
            if (remain < 0) continue;
            res += f[remain][i];
        }
        else cnt--;

    cout << res << "\n";
}
int main()
{
    freopen("input.txt", "r", stdin);
    init();
    while (cin >> n >> k) solve();
    return 0;
}