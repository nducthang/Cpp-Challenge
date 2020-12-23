#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
using namespace std;
#define MAX 1000
int n, arr[MAX];
void Diff(int l, int r, int& maxDiff, int& maxValue, int& minValue)
{
	if (l == r)
	{
		maxDiff = 0;
		maxValue = arr[l];
		minValue = arr[l];
		return;
	}

	int mid = (l + r) / 2;
	int maxD1, minD1, maxD2, minD2;
	int Diff1, Diff2;
	Diff(l, mid, Diff1, maxD1, minD1);
	Diff(mid + 1, r, Diff2, maxD2, minD2);
	maxDiff = max(max(Diff1, Diff2), maxD2 - minD1);
	maxValue = max(maxD1, maxD2);
	minValue = min(minD1, minD2);
}
int main()
{
	freopen("input.txt", "r", stdin);
	cin >> n;
	for (int i = 0; i < n; i++) cin >> arr[i];
	int maxDiff, maxValue, minValue;
	Diff(0, n - 1, maxDiff, maxValue, minValue);
	cout << maxDiff << endl;
	cout << maxValue << "-" << minValue << endl;
}