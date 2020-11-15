#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
#include <vector>
#include <cstring>
using namespace std;

int n, m;
struct DOMINO
{
	int x, y; // Toạ độ 2 con domino
	bool used1, used2; // False tức là chưa sử dụng
};
DOMINO x1, xn; // quân domino đầu và cuối
vector<DOMINO> v; // Lưu các giá trị domino của đề bài (m giá trị)
DOMINO temp; // quân domino tạm cho đọc dữ 
vector<bool> dd; // Đánh dấu xem quân domino nào trong m quân đã sử dụng
bool res;

void Try(int i, DOMINO pre)
{
	// Tìm số đang cần khớp
	int num_pre;
	if (pre.used1 == false) num_pre = pre.x;
	if (pre.used2 == false) num_pre = pre.y;
	// Duyệt tất cả các quân domino sẵn có
	for (int j = 0; j < v.size(); j++)
	{
		// Nếu quân nào chưa sử dụng
		if (dd[j])
		{
			if (v[j].x == num_pre)
			{
				if (i == n)
				{
					if (v[j].y == xn.x) res = true;
					return;
				}
				dd[j] = false;
				v[j].used1 = true;
				Try(i + 1, v[j]);
				v[j].used1 = false;
				dd[j] = true;
			}
			if (v[j].y == num_pre)
			{
				if (i == n)
				{
					if (v[j].x == xn.x ) res = true;
					return;
				}

				dd[j] = false;
				v[j].used2 = true;
				Try(i + 1, v[j]);
				v[j].used2 = false;
				dd[j] = true;
			}
		}

	}
}
int main()
{
	freopen("input.txt", "r", stdin);
	while (1)
	{
		cin >> n;
		if (n == 0) return 0;
		cin >> m >> x1.x >> x1.y >> xn.x >> xn.y;
		v.clear();
		for (int i = 1; i <= m; i++) {
			cin >> temp.x >> temp.y;
			v.push_back(temp);
		}
		// Khởi tạo tất cả các quân domino là chưa duyêkt
		dd.clear();
		dd.resize(v.size());
		fill(dd.begin(), dd.end(), true);
		res = false;
		x1.used1 = true;
		Try(1, x1);
		if (res)
			cout << "YES" << endl;
		else
			cout << "NO" << endl;
	}
}