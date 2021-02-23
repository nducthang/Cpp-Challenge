#include <iostream>
#include <vector>
using namespace std;
#define MAX 100002
typedef long long ll;
ll K;
bool isNT[MAX];
vector<ll> soNT;
void SangNguyenTo(ll n)
{
	isNT[0] = isNT[1] = true;
	for (ll i = 2; i <= n; i++)
	{
		if (isNT[i] == false)
		{
			soNT.push_back(i);
			for (ll j = 2; i * j <= n; j++)
			{
				isNT[i * j] = true;
			}
		}
	}
}
struct Number
{
	int i, j, k;
};
int main()
{
	cin >> K;
	SangNguyenTo(K);
	ll n = soNT.size();
	ll uocNT = 0;
	for (ll i = 0; i < n; i++)
	{
		if (K % soNT[i] == 0) {
			uocNT = soNT[i];
			break;
		}
	}
	vector<Number> kq;
	ll z;
	for (ll i = 0; i < n; i++)
	{
		for (ll j = i; j<n; j++)
		{
			if(K-soNT[i]-soNT[j]>=soNT[j])
			{
				z = K - soNT[i] - soNT[j];
				if (isNT[z] == false)
				{
					Number m;
					m.i = soNT[i];
					m.j = soNT[j];
					m.k = z;
					kq.push_back(m);
				}
			}
		}
	}
	cout << uocNT << endl;
	cout << kq.size() << endl;
	for (int i = 0; i < kq.size(); i++)
	{
		cout << kq[i].i << " " << kq[i].j << " " << kq[i].k << endl;
	}
}