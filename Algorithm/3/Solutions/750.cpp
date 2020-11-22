#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
#include <vector>
#include <cstring>
#include <map>
using namespace std;
int t,r,c;
vector<int> x(9); // mảng lưu kết quả
bool dd[9];
// x[i] tương ứng toạ độ theo dòng của cột thứ i
int dem = 0;
void Check()
{
	// Kiểm tra phương án thoả mãn hay không
	map<int, bool> cheochinh, cheophu;
	for (int i = 1; i <= 8; i++)
	{
		if (cheochinh[i + x[i]] == true || cheophu[i - x[i]] == true) return;
		cheochinh[i + x[i]] = true;
		cheophu[i - x[i]] = true;
	}
	c++;
	printf("%2d      ", ++dem);
	for (int i = 1; i <= 8; i++)
	{
		if (i != 1) cout << " ";
		cout << x[i];
	}
	cout << endl;
}
void Try(int i, int r)
{
	// Điều kiện dừng, nếu đã duyệt hết 8 cột

	if (i >= 9) Check();
	// Duyệt ở cột thứ i
	// thử các phương án cho cột thứ i, với i khác vị trí cố định
	if (i != r)
	{
		for (int j = 1; j <= 8; j++)
		{
			// Nếu hàng j chưa có quân hậu nào
			if (dd[j])
			{
				// Đặt quân hậu vào (i,j)
				x[i] = j;
				dd[j] = false;
				Try(i + 1, r);
				dd[j] = true;
			}
		}
	}
	else
	{
		Try(i + 1, r);
	}
}
int main()
{
	freopen("input.txt", "r", stdin);
	// Đọc số test
	cin >> t;
	for (int i = 1; i <= t; i++)
	{
		if (i != 1) cout << endl;
		// Đọc vị trí hàng và cột quân hậu đang đứng
		cin >> r >> c;
		cout << "SOLN       COLUMN\n";
		cout << " #      1 2 3 4 5 6 7 8\n\n";
		x.clear();
		x.resize(9);
		dem = 0;
		// Khởi tạo đánh dấu tất cả các hàng là rỗng
		memset(dd, true, sizeof(dd));
		// Đánh dấu vị trí quân hậu
		x[c] = r;
		dd[r] = false;
		Try(1, c);
	}
}