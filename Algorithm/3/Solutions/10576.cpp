#define _CRT_SECURE_NO_WARNINGS
/* PHÂN TÍCH BÀI TOÁN
Có 12 tháng, mỗi tháng đều có thặng dư và thâm hụt, nhưng chúng ta không biết tháng nào thặng dư và tháng nào thâm hụt
Chúng ta chỉ có thông tin là 8 báo cáo liên tiếp, mỗi báo cáo cách nhau 5 tháng đều báo cáo là thâm hụt
Chúng ta sẽ có 8 cách để nhóm 5 tháng liên tiếp lại với nhau tương ứng 8 báo cáo
	+ 1,2,3,4,5
	+ 2,3,4,5,6
	+ ...
	+ 8,9,10,11,12
Vậy có 8 báo cáo này đều báo cáo là thâm hụt.
Vậy tư tưởng của chúng ta sẽ là duyệt. Mỗi tháng sẽ có 2 lựa chọn là thặng dư hoặc thâm hụt
Số cách chọn là 2^12.
Bài toán đặt ra là có thặng dư không, nếu có thì phải tối đa hoá nó.
Bài toán quy về bài toán quay lui nhị phân
*/

#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;
int s, d;
void Try(vector<int>& monthValue, int s, int d, int& result, int current_month = 0, int current_sum = 0)
{
	// Nếu tháng đang xét  >=5 (tức là từ tháng 6 trở đi) thì kiểm tra điều kiện xem 5 tháng liên tiếp âm ko
	// Nếu không thì loại bỏ luôn trường hợp đang xét này
	if (current_month >= 5)
	{
		int sum = 0;
		for (int i = 1; i <= 5; i++)
		{
			sum += monthValue[current_month - i];
		}
		if (sum > 0) return;

	}

	// Nếu đã duyệt hết tất cả các tháng
	if (current_month == monthValue.size())
	{
		result = max(result, current_sum);
		return;
	}

	// Xét 2 trường hợp xảy ra
	monthValue[current_month] = s;
	Try(monthValue, s, d, result, current_month + 1, current_sum + s);

	monthValue[current_month] = -d;
	Try(monthValue, s, d, result, current_month + 1, current_sum - d);
}
int main()
{
	freopen("input.txt", "r", stdin);
	// s là thặng dư, d là thâm hụt
	while (cin >> s >> d)
	{
		// Khởi tạo giá trị cho 12 tháng trong năm là 0 hết
		vector<int> monthValue(12, 0); 
		int result = INT32_MIN;
		Try(monthValue, s, d, result);
		if (result < 0) cout << "Deficit" << endl;
		else cout << result << endl;
	}
}