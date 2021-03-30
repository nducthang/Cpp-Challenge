#include <iostream>

using namespace std;
int n, k, x[1000];
void Print()
{
	for (int i = 1; i <= k; i++)
		cout << x[i] << " ";
	cout << endl;
}
void Try(int i, int current_sum)
{
	if (i == k + 1)
	{
		if (current_sum == n) Print();
		return;
	}
	if (i > k + 1) return;
	for (int j = x[i-1] + 1; j <= n - current_sum; j++)
	{
		x[i] = j;
		Try(i + 1, current_sum + j);
	}
}
int main()
{
	cin >> n >> k;
	Try(1, 0);
}