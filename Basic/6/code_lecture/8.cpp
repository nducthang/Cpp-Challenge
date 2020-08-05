#include <iostream>
#include <ctime>
using namespace std;
#define MAX 100
void XuatMaTran(int a[MAX][MAX], int d, int c)
{
	for (int i = 0; i < d; i++)
	{
		for (int j = 0; j < c; j++)
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
void XepMang1ChieuGiamDan(int b[MAX], int m)
{
	for (int i = 0; i < m - 1; i++)
	{
		for (int j = i + 1; j < m; j++)
		{
			if (b[i] < b[j])
				Swap(b[i], b[j]);
		}
	}
}
void ZicZacNgang(int a[MAX][MAX], int d, int c)
{
	// Chuyển sang mảng 1 chiều và Sort
	int b[MAX];
	int m = 0;
	for (int i = 0; i < d; i++)
	{
		for (int j = 0; j < c; j++)
		{
			b[m++] = a[i][j];
		}
	}
	XepMang1ChieuGiamDan(b, m);
	// Gán lại vào mảng 2 chiều
	for (int i = 0; i < d; i++)
	{
		if (i % 2 == 0)
			for (int j = 0; j < c; j++)
				a[i][j] = b[--m];
		else
			for (int j = c - 1; j >= 0; j--)
				a[i][j] = b[--m];
	}
}
int main()
{
	srand(time(NULL));
	int a[MAX][MAX];
	int d = 5;
	int c = 4;
	for (int i = 0; i < d; i++)
		for (int j = 0; j < c; j++)
			a[i][j] = rand() % 1000;
	XuatMaTran(a, d, c);
	cout << "Sau khi sap xep: \n";
	ZicZacNgang(a, d, c);
	XuatMaTran(a, d, c);
	system("pause");
}