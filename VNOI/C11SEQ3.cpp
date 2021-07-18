#include <iostream>
#include <algorithm>
#include <vector>
using namespace std;
long long n;
string F[35];
string mul(string a)
{
    // a x 2
    int n = a.length();
    int carry = 0;
    string res = "";
    for(int i=n-1;i>=0;i--){
        int temp = 2*(a[i]-'0');
        res = char(temp%10+carry+'0') + res;
        if(temp>=10) carry = 1;
        else carry = 0;
    }
    if(carry==1) res = "1" + res;
    sort(res.begin(), res.end());
    return res;
}
int main()
{
    cin>>n;
    F[1] = "1";
    for(long long i=2;i<=30;i++){
        F[i] = mul(F[i-1]);
    }
    if(n<=24) cout<<F[n]<<endl;
    else {
        if(n%6==0) cout<<F[30]<<endl;
        else cout<<F[24+n%6]<<endl;
    }

}