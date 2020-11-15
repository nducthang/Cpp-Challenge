#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
#include <vector>
#include <cstring>

using namespace std;

#define MAX 105
#define BLACK 0
#define WHITE 1
#define NONE -1

int m, n, k, u, v;
vector<int> adj[MAX];
int color[MAX];
vector<int> res, tmp;
bool hasBlack(int i)
{
	for (int j = 0; j < adj[i].size(); j++)
	{
		if (color[adj[i][j]] == BLACK) return true;
	}
	return false;
}
void Try(int i)
{
	if (i == n + 1)
	{
		if (tmp.size() > res.size())
		{
			res = tmp;
		}
		return;
	}
	if (tmp.size() + n - i + 1 < res.size()) return;

	if (!hasBlack(i)) {
		color[i] = BLACK;
		tmp.push_back(i);
		Try(i + 1);
		tmp.pop_back();
	}

	color[i] = WHITE;
	Try(i + 1);
}
int main()
{
	freopen("input.txt", "r", stdin);
	cin >> m;
	for (int t = 1; t <= m; t++)
	{
		for (int i = 1; i < MAX; i++)
			adj[i].clear();
		cin >> n >> k;
		for (int i = 1; i <= k; i++)
		{
			cin >> u >> v;
			adj[u].push_back(v);
			adj[v].push_back(u);
		}
		memset(color, NONE, sizeof(color));
		res.clear(); tmp.clear();
		Try(1);
		cout << res.size() << endl;
		for (int j = 0; j < res.size(); j++)
		{
			if (j != res.size() - 1) cout << res[j] << " ";
			else cout << res[j] << endl;
		}

	}
}