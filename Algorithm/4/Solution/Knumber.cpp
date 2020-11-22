#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
#include <algorithm>
using namespace std;
int k;
string X;
int FindIndex()
{
	// tìm vị trí đầu tiên sao cho x1..xi có k+1 chữ số khác nhau
	int num[10] = { 0,0,0,0,0,0,0,0,0,0 };
	int c = 0;
	for (int i = 0; i < X.length(); i++)
	{
		if (num[X[i] - '0'] == 0) {
			num[X[i] - '0']++;
			c++;
		}
		if (c == k + 1) return i;
	}
	return -1;
}
int Check(int idx)
{
	int num[10] = { 0,0,0,0,0,0,0,0,0,0 };
	int c = 0;
	for (int i = 0; i < idx; i++)
	{
		if (num[X[i] - '0'] == 0) {
			num[X[i] - '0']++;
			c++;
		}
	}
	return c;
}
int main()
{
	freopen("input.txt", "r", stdin);
	cin >> k >> X;
	int idx = FindIndex();
	if (idx == -1) cout << X << endl;
	int m = *max_element(X.begin(), X.begin() + idx);
	if (m > X[idx])
	{
		// Thay x[idx] bằng số nhỏ nhất mà lớn hơn X[idx]
		// Tất cả các số sau thay bằng min{x1, .. x[i-1]}
		int a = '9';
		for (int j = 0; j < idx; j++)
		{
			if (X[j] > X[idx] && X[j] < a) a = X[j];
		}
		X[idx] = a;
		int b = *min_element(X.begin(), X.begin() + idx);
		for (int j = idx + 1; j < X.length(); j++) X[j] = b;
		cout << X << endl;
	}
	else
	{
		// Tăng x1...x(i-1) lên 1 đơn vị.
		int j = idx - 1;
		while (X[j] == '9')
		{
			X[j] == 0;
			j--;
		}
		X[j] += 1;
		// Nếu sau khi tăng có ít hơn k chữ số thì thay toàn bộ phía sau bằng 0
		// Nếu không thay bằng min{x1, ..., x(i-1)}
		int c = Check(idx);
		if (c < k)
		{
			for (int j = idx; j < X.length(); j++) X[j] = '0';
		}
		else
		{
			int b = *min_element(X.begin(), X.begin() + idx);
			for (int j = idx; j < X.length(); j++) X[j] = b;
		}
		cout << X << endl;
	}
}