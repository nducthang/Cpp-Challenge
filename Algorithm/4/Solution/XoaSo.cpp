#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
#include <vector>
using namespace std;
#define MAX 500005
long n;
long tem;
vector<long> v;
int main()
{
	freopen("input.txt", "r", stdin);
	cin >> n;
	for (int i = 1; i <= n; i++) {
		cin >> tem;
		v.push_back(tem);
	}
	for (vector<long>::iterator it = v.begin() + 1; it != v.end() - 1; it++)
	{
		if (v.size() >= 3 && *it < *(it - 1) && *it < *(it + 1))
		{
			v.erase(it);
			it = v.begin();
		}
	}
	cout << v.size();

}