#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
#include <cstring>
using namespace std;
#define MAX 30005
int n;
int mountain[MAX]; // Chiều cao ban đầu các dãy núi
bool isNT[MAX]; // i là số nguyên tố nếu isNT[i] == true
int sum[MAX]; // sum[i] = tổng của dãy núi 1 đến i
int leftCost[MAX]; // leftCost[i] = chi phí di chuyển các block 1 đến i
int rightCost[MAX]; // right[i] = chi phí di chuyển các block n đến i
int best = INT32_MAX;
void Enter()
{
	cin >> n;
	for (int i = 0; i < n; i++) cin >> mountain[i];
}
void Init()
{
	sum[0] = mountain[0];
	for (int i = 1; i < n; i++)
	{
		sum[i] = sum[i - 1] + mountain[i];
		leftCost[i] = leftCost[i - 1] + sum[i - 1];
	}
	rightCost[n - 1] = 0;
	for (int i = n - 2; i >= 0; i--)
	{
		rightCost[i] = rightCost[i + 1] + sum[n - 1] - sum[i];
	}
}
void SangNguyenTo()
{
	memset(isNT, true, sizeof(isNT));
	isNT[0] = isNT[1] = false;
	for (int i = 2; i < MAX; i++)
	{
		if (isNT[i] == true)
		{
			for (int j = 2 * i; j < MAX; j += i)
			{
				isNT[j] = false;
			}
		}
	}
}
void Process()
{
	for (int i = 0; i < n; i++)
	{
		// Trường hợp 1: Các khối đều năm trong 1 ngăn
		int cost1 = leftCost[i] + rightCost[i];
		if (cost1 < best) best = cost1;

		if (i <= n - 2)
		{
			// Trường hợp 2
			int cost2 = leftCost[i] + mountain[i + 1] + rightCost[i + 2];
			if (cost2 < best) best = cost2;
		}
		// Duyệt các số nguyên tố
		// Xét các số nguyên tố khác >2
		for (int j = 3; j < n - i; j++)
		{
			int p;
			if (isNT[j]) p = j;
			else continue;
			// Trường hợp P: Các khối nằm trong 2 ngăn, cách nhau 1 số nguyên tố
			// Di chuyển trái về i, phải về i+p
			int costP = leftCost[i] + rightCost[i + p];

			// Bên trong khoảng p chúng ta chia làm đổi, di chuyển nửa bên trái về i, và nửa bên phải về i+p
			int mid = p / 2;
			// Chi phí di chuyển nửa bên trái
			int rightmove = rightCost[i] - rightCost[i + mid + 1] - (mid + 1) * (sum[n-1] - sum[i + mid]);
			// Chi phí di chuyển nửa bên phải
			int leftmove = leftCost[i + p] - leftCost[i + mid] - (mid + 1) * sum[i + mid];

			costP += rightmove;
			costP += leftmove;
			if (costP < best) best = costP;

			if (i >= 2 && isNT[p + 2])
			{
				// Trường hợp 2P: Các khối nằm trong 3 ngăn, 2 khối đầu cách nhau 2, khối cuối cách nhau 1 số nguyên tố
				int cost2P = costP - leftCost[i] + leftCost[i - 2] + mountain[i - 1];
				if (cost2P < best) best = cost2P;
			}
			if (i + p < n - 2 && isNT[p + 2])
			{
				// Case P2: 3 ngăn, 2 ngăn đầu cách nhau 1 số nguyên tố, tiếp theo là cách nhau 2
				int costP2 = costP - rightCost[i + p] + rightCost[i + p + 2] + mountain[i + p + 1];
				if (costP2 < best) best = costP2;
			}
			if (i >= 2 && i + p < n-2 && isNT[p + 2] && isNT[p + 4])
			{
				// Case 2P2: 4 khối, đầu và cuối cách nhau 2, giữa cách nhau 1 số nguyên tố
				int cost2P2 = costP - leftCost[i] + leftCost[i - 2] + mountain[i - 1]
					- rightCost[i + p] + rightCost[i + p + 2] + mountain[i + p + 1];
				if (cost2P2 < best) best = cost2P2;
			}

		}
	}
}
int main()
{
	freopen("input.txt", "r", stdin);
	SangNguyenTo();
	Enter();
	Init();
	Process();
	cout << best;
}