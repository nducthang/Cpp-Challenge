#include <iostream>
#include <vector>
using namespace std;
int m, n;
bool isNT[1002];
vector<int> v;
void SangNT(int n)
{
	isNT[0] = isNT[1] = true;
	for (int i = 2; i <= n; i++)
	{
		if (isNT[i] == false)
		{
			v.push_back(i);
			for (int j = 2; i * j <= n; j++)
			{
				if (isNT[i * j] == false)
					isNT[i * j] = true;
			}
		}
	}
}
int main()
{
	cin >> m >> n;
	SangNT(n);
	for (int i = 1; i < v.size(); i++)
	{
		if (v[i] - v[i - 1] == 2) cout << v[i - 1] << " " << v[i] << endl;
	}
}