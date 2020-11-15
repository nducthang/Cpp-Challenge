#define _CRT_SECURE_NO_WARNINGS
/*
Quy về bài toán liệt kê tổ hợp chập k của n
Ví dụ với n=4 và k=2 thì chúng ta có các cặp là 12,13,14,23,24,34
Tương ứng đây là các chỉ số mà sẽ hiển thị các cặp string với nhau
*/
#include <iostream>
#include <string>
#include <vector>
#include <cctype>
#include <cstdio>
using namespace std;
int T, a, b;
vector<int> x(1000);
string temp, order;
vector<string> v;
void Show(int k)
{
	for (int i = 1; i <= k; i++)
	{
		cout << v[x[i] - 1];
		if (i < k) cout << ", ";
	}
	cout << endl;
	
}
void Try(int i, int k, int n)
{
	if (i == k + 1)
	{
		Show(k);
		return;
	}
	for (int j = i; j <= n; j++)
	{
		if (j > x[i - 1])
		{
			x[i] = j;
			Try(i + 1, k, n);
		}
	}
}
int main()
{
	freopen("input.txt", "r", stdin);
	// Đọc số test
	scanf("%d\n", &T);
	// Duyệt từng bộ test
	while(T--)
	{
		v.clear();
		x.clear(); x.resize(1000);
		getline(cin, order);
		while (getline(cin, temp), temp != "")
		{
			v.push_back(temp);
		}
		if (sscanf(order.c_str(), "%d %d", &a, &b) == 2)
		{
			for (int j = a; j <= b; j++)
			{
				cout << "Size " << j << endl;
				Try(1, j, v.size());
				cout << endl;
			}
		}
		else if (sscanf(order.c_str(), "%d", &a) == 1)
		{
			cout << "Size " << a << endl;
			Try(1, a, v.size());
			cout << endl;
		}
		else
		{
			for (int j = 1; j <= v.size(); j++)
			{
				cout << "Size " << j << endl;
				Try(1, j, v.size());
				cout << endl;
			}
		}
		if(T) cout << endl;
	}
}