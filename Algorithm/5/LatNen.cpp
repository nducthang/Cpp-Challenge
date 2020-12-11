#include <iostream>
using namespace std;
#define MAX 100
int k;
int c = 0;
int a[MAX][MAX];
void cover(int x, int y, int s, int t)
{
	if (s == 2)
	{
		c++;
		if (t != 1) a[x][y] = c;
		if (t != 2) a[x][y + 1] = c;
		if (t != 3) a[x + 1][y] = c;
		if (t != 4) a[x + 1][y + 1] = c;
		return;
	}
	if (t == 1)
	{
		cover(x, y + s / 2, s / 2, 3);
		cover(x + s / 2, y, s / 2, 2);
		cover(x + s / 2, y + s / 2, s / 2, 1);
		cover(x + s / 4, y + s / 4, s / 2, 1);
	}
	if (t == 2)
	{
		cover(x, y, s / 2, 4);
		cover(x + s / 2, y, s / 2, 2);
		cover(x + s / 2, y + s / 2, s / 2, 1);
		cover(x + s / 4, y + s / 4, s / 2, 2);
	}
	if (t == 3)
	{
		cover(x, y, s / 2, 4);
		cover(x, y + s / 2, s / 2, 3);
		cover(x + s / 2, y + s / 2, s / 2, 1);
		cover(x + s / 4, y + s / 4, s / 2, 3);
	}
	if (t == 4)
	{
		cover(x, y, s / 2, 4);
		cover(x + s / 2, y, s / 2, 2);
		cover(x, y + s / 2, s / 2, 3);
		cover(x + s / 4, y + s / 4, s / 2, 4);
	}
}
int main()
{
	cin >> k;
	cover(1, 1, 1<<k, 2);
	for (int i = 1; i <= 1 << k; i++)
	{
		for (int j = 1; j <= 1 << k; j++)
			cout << a[i][j] << " ";
		cout << endl;
	}
}