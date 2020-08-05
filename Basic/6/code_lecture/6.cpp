#include <iostream>
using namespace std;
#define MAX 100
void Pascal(int n)
{
	int a[MAX][MAX];
	for (int i = 1; i <= n; i++)
	{
		a[i][1] = 1;
		a[i][i] = 1;
	}
	// a[i][j]=a[i-1][j-1]+a[i-1][j]
	for (int i = 2; i <= n; i++)
	{
		for (int j = 2; j <= n; j++)
		{
			if(i>j)
				a[i][j] = a[i - 1][j - 1] + a[i - 1][j];
		}
	}
	// Print result
	for (int i = 1; i <= n; i++)
	{
		for (int j = 1; j <= i; j++)
			cout << a[i][j] << "\t";
		cout << endl;
	}
}
int main()
{
	Pascal(8);
	system("pause");
}