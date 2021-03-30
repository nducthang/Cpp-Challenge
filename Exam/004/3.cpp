#include <iostream>
#include <string>
#include <algorithm>
using namespace std;
typedef long long ll;
#define MAX 26
ll n, m;
string a[MAX];
int main()
{
	cin >> a[0] >> n >> m;
	for (int i = 1; i <= n; i++)
	{
		a[i] = a[i - 1] + string(a[i-1].rbegin(), a[i-1].rend());
	}
	if (m-1 >= a[n].size())
		cout << -1 << endl;
	else
		cout << a[n][m - 1] << endl;
}