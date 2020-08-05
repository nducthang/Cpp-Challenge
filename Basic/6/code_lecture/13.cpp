#include <iostream>
#include <ctime>
using namespace std;
#define MAX 100
void XuatMaTran(int a[MAX][MAX], int n)
{
	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < n; j++)
		{
			cout << a[i][j] << "\t";
		}
		cout << endl;
	}
}
void Swap(int &a, int &b)
{
	int temp = a;
	a = b;
	b = temp;
}
void SapXep(int b[], int n, int a[MAX][MAX])
{
	int i, j, t = 0;
	for (i = 0; i < n; i++)
	{
		for (j = 0; j < n; j++)
		{
			b[t++] = a[i][j];
		}
	}
	for (i = 0; i < n*n - 1; i++)
	{
		for (j = i + 1; j < n*n; j++)
		{
			if (b[i] > b[j])
			{
				Swap(b[i], b[j]);
			}
		}
	}
}
/** Ma Tran Minh hoa
1 1 1 1 1
4 1 1 1 2
4 4 X 2 2
4 3 3 2 2
3 3 3 3 2
Ma tran se duyet lan luot tu ngoai vao trong
1 1 1 1 -> dong so 0
2 2 2 2 -> cot n-1
3 3 3 3 -> dong n-1
4 4 4 4 -> cot so 0
nhu vay ta se dc vien ngoai cua ma tran,tuong tu cac vien ben trong
**/
void XepMang(int a[MAX][MAX], int b[], int n)
{
	int i = 0, j, l = 0, k;
	while (i < n*n)
	{
		//n=5 , l=0
		for (j = l; j < n - l; j++)
		{
			a[l][j] = b[i++]; //00 01 02 03 04
		}
		for (k = l + 1; k < n - l; k++)
		{
			a[k][n - l - 1] = b[i++];// 14 24 34 44
		}
		for (j = n - l - 2; j >= l; j--)
		{
			a[n - l - 1][j] = b[i++]; // 43 42 41 40
		}
		for (k = n - l - 2; k > l; k--)
		{
			a[k][l] = b[i++]; //03 02 01
		}
		l++;
	}

}
int main()
{
	srand(time(NULL));
	int a[MAX][MAX];
	int n = 5;
	for (int i = 0; i < n; i++)
		for (int j = 0; j < n; j++)
			a[i][j] = rand() % 1000;
	XuatMaTran(a, n);
	cout << "Sau khi sap xep: \n";
	int b[MAX];
	SapXep(b, n, a);
	XepMang(a, b, n);
	XuatMaTran(a, n);
	system("pause");
}