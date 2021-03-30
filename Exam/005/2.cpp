#include <iostream>
#include <algorithm>
using namespace std;
int m, n, x[100];
void Print()
{
	for (int i = 1; i <= n; i++)
	{
		cout << x[i] << " ";
	}
	cout << endl;
}
void Try(int i, int current_sum)
{
	if (i == n + 1)
	{
		if (current_sum == m) Print();
		return;
	}
	for (int j = m - current_sum; j >= 0; j--)
	{
		if (j <= x[i - 1])
		{
			x[i] = j;
			Try(i + 1, current_sum + j);
		}
	}
}
int main()
{
	cin >> m >> n;
	x[0] = m;
	Try(1, 0);
}