#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
#include <algorithm>
using namespace std;
#define MAX 100002
int n, k, u, v;
int a[MAX];
bool lessN(int i)
{
	return (i <= n);
}
int main()
{
	freopen("input.txt", "r", stdin);
	cin >> n >> k;
	// Khoi tao ban dau
	for (int i = 1; i <= 2 * n; i++) a[i] = i;
	for (int i = 1; i <= k; i++)
	{
		cin >> u >> v;
		swap(a[u], a[v]);
		cout << count_if(a + 1, a + n + 1, lessN) << endl;
	}
}