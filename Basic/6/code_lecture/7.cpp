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
void XepDungMangPhu(int a[MAX][MAX], int n)
{
	int b[MAX];
	int m = 0;
	// Chuyen Doi a sang b
	for (int i = 0; i < n; i++)
		for (int j = 0; j < n; j++)
			b[m++] = a[i][j];
	// Sort b
	for (int i = 0; i < m - 1; i++)
	{
		for (int j = i + 1; j < m; j++)
		{
			if (b[i] < b[j])
				Swap(b[i], b[j]);
		}
	}
	// Gan b lai vao a
	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < n; j++)
		{
			a[i][j] = b[--m];
		}
	}
	// Print Value
	XuatMaTran(a, n);
}
void XepKhongDungMangPhu(int a[MAX][MAX], int n)
{
	for (int i = 0; i < n * n - 1; i++)
		for (int j = i + 1; j < n * n; j++)
			if (a[i / n][i%n] > a[j / n][j%n])
				Swap(a[i / n][i%n], a[j / n][j%n]);
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
	//XepDungMangPhu(a, n);
	XepKhongDungMangPhu(a, n);
	XuatMaTran(a, n);
	system("pause");
}