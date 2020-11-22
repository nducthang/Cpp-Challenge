#define _CRT_SECURE_NO_WARNINGS
/*
Chúng ta sử dụng đệ quy để di chuyển các quân hậu theo hàng ngang.
Nếu như đến lúc nào kết quá đã ok thì chúng ta dừng
https://saicheems.wordpress.com/2013/08/06/uva-11085-back-to-the-8-queens/
*/
#include <iostream>
#include <vector>
using namespace std;
vector<int> queen(8);
vector<int> path(8);
bool Check(int r, int c)
{
	for (int j = 0; j < r; j++) {
		if (c == path[j]) return false;
		if (abs(r - j) == abs(c - path[j])) return false;
	}
	return true;
}
int Try(int n)
{
	if (n == 8) return 0;

	int tot = 100000;

	for (int i = 0; i < 8; i++)
		if (Check(n, i)) {
			path[n] = i;
			tot = min(tot, i == queen[n] ? Try(n + 1) : 1 + Try(n + 1));
		}

	return tot;
}
int main()
{
	freopen("input.txt", "r", stdin);

	for (int T = 1;; T++)
	{
		queen.clear(); path.clear();
		queen.resize(8); path.resize(8);
		// Đọc dữ liệu vị trí 8 quân hậu
		for (int i = 0; i < 8; i++)
		{
			if (!(cin >> queen[i])) return 0;
			queen[i]--; path[i] = queen[i];
		}
		cout << "Case " << T << ": " << Try(0) << endl;
	}
}