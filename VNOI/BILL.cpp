#include <iostream>
using namespace std;
typedef long long ll;
ll x,y;
ll calMoney(ll u)
{
    if (u <= 100) return u * 200;
	if (u <= 10000) return calMoney(100) + (u - 100) * 300;
	if (u <= 1000000) return calMoney(10000) + (u - 10000) * 500;
	return calMoney(1000000) + (u - 1000000) * 700;
}
ll calKwh(ll u)
{
    if(calMoney(100)>=u) return u/200;
    else if(calMoney(10000)>=u) return 100 + (u-calMoney(100))/300;
    else if(calMoney(1000000)>=u) return 10000+(u-calMoney(10000))/500;
    else return 1000000 + (u-calMoney(1000000))/700;    
}
int main()
{
    cin>>x>>y;
    ll totalKwh = calKwh(x), low = 0, hight = totalKwh/2, ans = 0;
    while(low <= hight)
    {
        ll mid = (low+hight)/2;
        ll dif = calMoney(totalKwh-mid) - calMoney(mid);
        if(dif == y){
            ans = mid;
            break;
        }
        if(dif < y) hight = mid - 1;
        else low = mid + 1;
    }
    cout<<calMoney(ans);
}