#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
#include <algorithm>
using namespace std;
#define MAX 100
struct WORK
{
	int p;
	int d;
};
int n;
WORK a[MAX];
int x[MAX];
int c = 0;
bool cmp(WORK x, WORK y)
{
	if (x.d != y.d) return (x.d < y.d);
	else return (x.p < y.p);
}
int main()
{
	freopen("input.txt", "r", stdin);
	cin >> n;
	for (int i = 1; i <= n; i++) cin >> a[i].p;
	for (int i = 1; i <= n; i++) cin >> a[i].d;
	sort(a + 1, a + n + 1, cmp);
	int end = 0;
	for (int i = 1; i <= n; i++)
	{
		if (end + a[i].p <= a[i].d)
		{
			x[c++] = i;
			end += a[i].p;
		}
	}
	cout << c << endl;
	for (int j = 0; j < c; j++) cout << x[j] << " ";

}