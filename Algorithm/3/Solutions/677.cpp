#define _CRT_SECURE_NO_WARNINGS

#include <iostream>
#include <cstring>
#include <vector>
using namespace std;
#define MAX 100
int m, n;
int a[MAX][MAX];
bool dd[MAX];
int num_path;
vector<int> v; // Lưu lại đường đi
void Show()
{
	// Hiển thị kết quả
	num_path++;
	cout << "(";
	for (int i = 0; i < v.size(); i++)
	{
		cout << v[i];
		if (i != v.size() - 1) cout << ",";
		else cout << ")" << endl;
	}
}
void Try(int i, int current_d = 0)
{
	if (current_d == n) {
		Show();
		return;
	}
	// Duyệt tất cả các đỉnh
	for (int j = 1; j <= m; j++)
	{
		// Nếu đỉnh đó chưa duyệt và tồn tại đường đi
		if(dd[j] && a[i][j])
		{
			v.push_back(j);
			dd[j] = false;
			Try(j, current_d + 1);
			v.pop_back();
			dd[j] = true;
		}
	}
}
int main()
{
	freopen("input.txt", "r", stdin);
	// Đọc dữ liệu
	while (1)
	{
		cin >> m >> n;
		for (int i = 1; i <= m; i++)
			for (int j = 1; j <= m; j++)
				cin >> a[i][j];
		// Xử lý mỗi test
		// Duyệt thử với đỉnh thứ 1 là đỉnh xuất phát
		// Khởi tạo tất cả các đỉnh là chưa duyệt
		memset(dd, true, sizeof(dd));
		// Reset lại đường đi
		v.clear();
		// reset lại biến đêm
		num_path = 0;
		v.push_back(1);
		dd[1] = false;
		Try(1);
		if (num_path == 0) cout << "no walk of length " << n << endl;
		// Đọc -9999
		int temp;
		while (!(cin >> temp)) return 0;
		// Dòng trống giữa các test
		cout << endl;
	}
}