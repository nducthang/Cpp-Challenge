#include <iostream>
using namespace std;
#define MAX 17
int n;
long C[MAX][MAX];
bool Free[MAX];
long T[MAX];
long configuration = 100001 * 17;
long x[MAX];
void Enter()
{
	cin >> n;
	for (int i = 1; i <= n; i++)
		for (int j = 1; j <= n; j++)
			cin >> C[i][j];
}
void Init()
{
	for (int i = 1; i <= n; i++)
		Free[i] = true;
	T[0] = 0;
}
void Result()
{
	long present = 0;
	for (int i = 1; i <= n - 1; i++)
	{
		present += C[x[i]][x[i + 1]];
	}
	if (present < configuration)
		configuration = present;
}
void Try(int i)
{
	for (int j = 1; j <= n; j++)
	{
		if (Free[j] && C[x[i - 1]][j] && C[x[i - 1]][j] + T[i - 1] < configuration)
		{
			x[i] = j;
			T[i] = T[i - 1] + C[x[i - 1]][j];
			if (i == n) Result();
			else
			{
				Free[j] = false;
				Try(i + 1);
				Free[j] = true;
			}
		}
	}
}
void Process()
{
	for (int i = 1; i <= n; i++)
	{
		Init();
		x[1] = i;
		Free[i] = false;
		Try(2);
	}
	cout << configuration << endl;
}
int main()
{
	Enter();
	Process();
}
