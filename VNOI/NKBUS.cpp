/*
Thời gian đợi để có thể chở nhân viên
Thời gian đợi  = thời điểm nhân viên đến điểm hẹn - thời gian để xe đi đến điểm hẹn đó
Sắp xếp thời gian đợi theo thứ tự tăng dần, sau đó chọn m thằng đầu tiên.
Nếu mà xe mà chở dc nhiều hơn số nhân viên --> chọn tất
*/
#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;
#define MAX 200000
int n,m;
vector<int> a;
int t,k,x;
int sum = 0;
int wait_time;
int main()
{
    cin>>n>>m;
    for(int i=1;i<=n;i++)
    {
        cin>>t>>k;
        for(int j=1;j<=k;j++)
        {
            cin>>x;
            a.push_back(x);
        }
        sum += t;
    }
    sort(a.begin(), a.end());
    // code tiep
    if(m>a.size()){
        wait_time = a.back();
    }
    else{
        wait_time = a[m-1];
    }
    if (wait_time < 0) wait_time = 0;
    cout << sum + wait_time;
}