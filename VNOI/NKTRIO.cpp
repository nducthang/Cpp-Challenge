#include <iostream>
#include <algorithm>
using namespace std;
int a[1001][1001], father[1005], n;
void Try(int i) {
    for (int j = 1; j <= n; j++) {
        if (a[i][j] == 1) {
            if (father[j] == 0) {
                father[j] = i;
                Try(j);
            }
            else if (father[i] > 0 && a[j][father[i]] == 1) {
                cout << i <<  " " << j << " " << father[i];
                exit(0);
            }
        }
    }
}
int main()
{
    cin >> n;
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= n; j++) {
            cin >> a[i][j];
        }
    }
    for (int i = 1; i <= n; i++) {
        if (father[i] == 0) {
            father[i] = -1;
            Try(i);
        }
    }
    cout<<"-1 -1 -1"<<endl;
}