#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
#include <algorithm>
using namespace std;
#define MAX 25
#define MAXC 999999
int n, S;
int t[MAX];
int x[MAX]; // ket qua
int c; // so to dc lay
bool cmp(int a, int b)
{
	return a > b;
}
int main()
{
	freopen("input.txt", "r", stdin);
	cin >> n >> S;
	for (int i = 1; i <= n; i++) cin >> t[i];
	sort(t + 1, t + n + 1, cmp);
	int idx = 1;
	for (int j = 1; j <= n; j++)
	{
		if (t[j] <= S)
		{
			c++;
			S -= t[j];
			x[idx++] = t[j];
			t[j] = MAXC;
		}
	}
	if (S != 0) cout << -1 << endl;
	else
	{
		cout << c << endl;
		int j = 1;
		while (j < idx) {
			cout << x[j] << " ";
			j++;
		}
	}


}