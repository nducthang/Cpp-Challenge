#include <iostream>
using namespace std;
typedef long long ll;
ll Pow(ll a, ll k)
{
	if (k == 1) return a;
	ll temp = Pow(a, k / 2);
	if (k % 2 == 0) return temp * temp;
	else return temp * temp * a;
}

int main()
{
	//int a, n;
	//cin >> a >> n;
	cout << Pow(9, 13) << endl;
}