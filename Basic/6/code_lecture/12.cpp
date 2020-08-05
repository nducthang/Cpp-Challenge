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
void Xoay90NguocKimDongHo(int a[MAX][MAX], int d, int c)
{
	// b là ma trận mới
	int b[MAX][MAX];
	for (int i = 0; i < c; i++)
	{
		for (int j = 0; j < d; j++)
		{
			b[i][j] = a[j][c - i - 1];
		}
	}
	XuatMaTran(b, c, d);
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
	Xoay90NguocKimDongHo(a, d, c);
	system("pause");
}