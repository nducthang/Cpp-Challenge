#define _CRT_SECURE_NO_WARNINGS
/*
* Quy về bài toán liệt kê các dãy nhị phân có k ký tự 1 trong số tổng n ký tự
* Chú ý đề bài output phải in dòng trống giữa các đầu ra
*/
#include <iostream>
using namespace std;
int T, n,k;
int x[1000];
void Check(int current_sum)
{
	if (current_sum == k)
	{
		for (int i = 0; i < n; i++)
			cout << x[i];
		cout << endl;
	}
}
void Try(int i, int current_sum = 0)
{
	if (current_sum > k) return;
	if (i == n) {
		Check(current_sum);
		return;
	}
	x[i] = 0;
	Try(i + 1, current_sum);
	x[i] = 1;
	Try(i + 1, current_sum + 1);
}
int main()
{
	freopen("input.txt", "r", stdin);
	cin >> T;
	for (int t = 1; t <= T; t++)
	{
		cin >> n >> k;
		if (t!=1 && k > 0) cout << endl;
		Try(0, 0);
	}
}