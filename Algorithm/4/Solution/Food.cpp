#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
#include <algorithm>
using namespace std;
#define MAX 100002
int m, k;
int c[MAX];
int result = 0;
int main()
{
	freopen("input.txt", "r", stdin);
	cin >> m >> k;
	for (int i = 1; i <= m; i++) cin >> c[i];
	for (int i = 1; i <= m; i++)
	{
		int start = max(1, i - k + 1);
		int minElement = *min_element(c + start, c + i + 1);
		result += 2 * minElement;
	}
	cout << result << endl;
}