#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
using namespace std;
#define MAX 100002
int m, w, n, t, i, j;
int a[MAX];
int main()
{
	freopen("input.txt", "r", stdin);
	cin >> m >> w >> n;
	for (i = 1; i <= n; i++)
	{
		cin >> t;
		for (j = 1; j <= m; j++)
		{
			if (w - a[j] >= t) {
				a[j] += t;
				cout << j << endl;
				break;
			}
		}
		if (j == m + 1) cout << -1 << endl;
	}
}