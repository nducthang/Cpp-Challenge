#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
#include<map>
#include<vector>
using namespace std;

int t, n;
int ar[20]; // Lưu mảng đầu vào
map<vector<int>, bool > solutions; // Lưu kết quả tổng
vector<int> v; // lưu 1 kết quả tạm thời

void search(int k, int m, int sum, vector<int> v) {
    // nếu tổng đã bằng t thì thực hiện kiểm tra xem đã có chưa, nếu chưa xuất ra
    if (sum == t) {
        // Nếu phương án đã có
        if (solutions[v] == true) return;
        // Nếu phương án chưa có thì gán bằng true
        solutions[v] = true;
        // xuất kết quả
        for (int i = 0; i < k; i++)
            if (i == k - 1) cout << v[i];
            else cout << v[i] << "+";
        cout << endl;
        return;
    }
    // Nếu tổng lớn hơn t hoặc đã duyệt hết
    if (sum > t || m == n) return;
    // xét các chỉ số từ m trở đi
    for (int i = m; i < n; i++) {
        v.push_back(ar[i]);
        search(k + 1, i + 1, sum + ar[i], v);
        v.pop_back();
    }
}

int main() {
    freopen("input.txt", "r", stdin);
    for (;;) {
        cin >> t >> n;
        if (t == 0 && n == 0) break;
        for (int i = 0; i < n; i++)
            cin >> ar[i];
        solutions.clear();
        cout << "Sums of " << t << ":" << endl;
        search(0, 0, 0, v);
        if (solutions.size() == 0) cout << "NONE" << endl;
    }
}