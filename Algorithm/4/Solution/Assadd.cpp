#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
#include <algorithm>
using namespace std;
#define MAX 100005
int n, q;
string temp;
int x, y, z;
int arr[MAX];
int main()
{
	freopen("input.txt", "r", stdin);
	cin >> n >> q;
	for (int i = 1; i <= q; i++)
	{
		cin >> temp;
		if (temp == "ASS") {
			cin >> x >> y >> z;
			fill(arr + x, arr + y + 1, z);
		}
		else if (temp == "SUM")
		{
			cin >> x >> y;
			int sum = 0;
			for (int j = x; j <= y; j++) sum += arr[j];
			cout << sum << endl;
		}
		else if (temp == "MIN")
		{
			cin >> x >> y;
			cout << *min_element(arr + x, arr + y + 1) << endl;
		}
		else if (temp == "MAX")
		{
			cin >> x >> y;
			cout << *max_element(arr + x, arr + y + 1) << endl;
		}
		else
		{
			// INC
			cin >> x >> y >> z;
			for (int j = x; j < y; j++) arr[j] += z;
		}
	}
}