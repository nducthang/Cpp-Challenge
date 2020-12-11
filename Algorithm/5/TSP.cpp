#define _CRT_SECURE_NO_WARNINGS

#include <iostream>
using namespace std;
#define MAX 102
#define MAXC 999999
int n, u, v, w, C[MAX][MAX], best;
bool dd[MAX];
int x[MAX];
int res =0 , xi;
int main()
{
	freopen("input.txt", "r", stdin);
	cin >> n;
	x[1] = 1;
	dd[1] = true;
	// Khoi tao C
	for (int i = 1; i <= n; i++)
		for (int j = 1; j <= n; j++)
			C[i][j] = MAXC;
	while (cin >> u >> v >> w)
	{
		C[u][v] = C[v][u] = w;
	}
	for (int i = 2; i <= n; i++)
	{
		// Chon nghiem x[i]
		best = MAXC;
		for (int j = 2; j <= n; j++)
		{
			if (dd[j] == false && C[x[i-1]][j] < best)
			{
				best = C[x[i-1]][j];
				xi = j;
			}
		}
		x[i] = xi;
		dd[xi] = true;
		res += C[x[i - 1]][x[i]];
	}
	res += C[x[n]][x[1]];
	x[n + 1] = 1;
	cout << res << endl;
	for (int i = 1; i <= n + 1; i++)
		cout << x[i] << " ";
}