#define _CRT_SECURE_NO_WARNINGS

#include <iostream>
#include <vector>
using namespace std;
int n;

// Xây dựng cấu trúc dữ liệu cho cuộc gọi
struct CALL
{
	int source;
	int time;
	int duration;
	int target;
};
// vector lưu trữ thông tin chuyển tiếp cuộc gọi
vector<CALL> v;
int Process(int n, int startTime, int extension, int pre)
{
	// n là số sâu của đệ quy
	// startTime là thời điểm thực hiện cuộc gọi
	// extension là số gọi đến
	// pre là số nguồn (sử dụng cho đệ quy)
	// Nếu n>0 và cuộc gọi bị quay vòng trở lại thì trả về 9999
	if (n > 0 && extension == pre) return 9999;
	// Duyệt tất cả các cuộc gọi đang có
	for (int i = 0; i < v.size(); i++)
	{
		if (extension == v[i].source)
		{
			// Nếu khoảng thời gian của cuộc gọi đang xét nằm trong khoảng chuyển tiếp
			// Thì đệ quy để tiếp tục xử lý cuộc gọi chuyển tiếp
			if (startTime >= v[i].time && startTime <= v[i].time + v[i].duration)
				return Process(n + 1, startTime, v[i].target, pre);
		}
	}
	// Nếu như không bị chuyển tiếp thì gọi được vào số đó
	return extension;
}
int main()
{
	freopen("input.txt", "r", stdin);
	cout << "CALL FORWARDING OUTPUT" << endl;
	// Nhập vào số test
	cin >> n;
	// Duyệt tất cả các test
	for (int i = 1; i <= n; i++)
	{
		cout << "SYSTEM " << i << endl;;
		// Đọc thông tin dữ liệu và lưu lại vào vector
		// Với mỗi test, ta phải clear lại vector
		v.clear();
		int source, time, duration, target;
		for (;;)
		{
			cin >> source;
			// Nếu như đọc tới dòng 0000 thì source  = 0. Khi đó kết thúc đọc dữ liệu phần này
			if (source == 0) break;
			cin >> time >> duration >> target;
			CALL add = { source, time, duration, target };
			v.push_back(add);
		}
		// Đọc tiếp các thông tin về các cuộc gọi
		// Đồng thời xử lý cho từng cuộc gọi
		int startTime, extension;
		for (;;)
		{
			cin >> startTime;
			if (startTime == 9000) break;
			cin >> extension;
			// Dùng printf để điều khiển định dạng đầu ra cho đúng và đơn giản
			printf("AT %04d CALL TO %04d RINGS %04d\n", startTime, extension, Process(0, startTime, extension, extension));
		}
	}
	cout << "END OF OUTPUT" << endl;


}