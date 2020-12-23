#include <iostream>
using namespace std;
int n;
void move(int n, int src, int dst, int tmp)
{
	if (n == 1) cout << "Move " << src << " to " << dst << endl;
	else
	{
		move(n - 1, src, tmp, dst);
		move(1, src, dst, tmp);
		move(n - 1, tmp, dst, src);
	}
}
int main()
{
	cin >> n;
	move(n, 1, 3, 2);
}