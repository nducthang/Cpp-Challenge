#define _CRT_SECURE_NO_WARNINGS

#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;
long n, u, v, res = 0;
struct MACHINE
{
	long d;
	long t;
	bool dd;
};
vector<MACHINE> m;
bool cmp(MACHINE a, MACHINE b)
{
	return a.d < b.d;
}
int main()
{
	freopen("input.txt", "r", stdin);
	cin >> n;
	for (int i = 1; i <= n; i++)
	{
		cin >> u >> v;
		MACHINE temp;
		temp.d = u;
		temp.t = v;
		temp.dd = true;
		m.push_back(temp);
	}
	sort(m.begin(), m.end(), cmp);
	long sm = 0;
	long n = m.size(), tg;
	for (long i = 0; i < n; i++)
	{
		if (m[i].dd)
		{
			sm++;
			tg = m[i].d + m[i].t;
			for (long j = i + 1; j < n; j++)
			{
				if (tg <= m[j].d)
				{
					m[j].dd = false;
					tg = m[j].d + m[j].t;
				}
			}
		}
	}
	cout << sm << endl;

}