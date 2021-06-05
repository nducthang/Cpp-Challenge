#include <iostream>
using namespace std;
typedef long long ll;
ll n,m, result;
int main()
{
    cin>>n>>m;
    result = n*m;
    while(result>n) result += (result - n - 1)/(m-1) - n;
    cout<<result<<endl;
}