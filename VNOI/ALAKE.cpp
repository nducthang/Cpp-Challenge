#include <iostream>
#include <algorithm>
using namespace std;
#define MAX 100002
#define oo 1e9+2
typedef long long ll;
ll n, w[MAX], h[MAX];
ll pre[MAX], nex[MAX];
ll res[MAX];

int main()
{
    cin>>n;
    for(ll i=1;i<=n;i++) cin>>w[i]>>h[i];
    h[0] = h[n+1] = oo;
    for(ll i=0;i<=n+1;i++){
        pre[i] = i-1;
        nex[i] = i+1;
    }
    // Tim noi co chieu cao thap nhat
    ll index = min_element(h+1, h+n+1) - h;
    ll total = 0;
    while(h[index] < oo)
    {
        // thoi gian lap day doan index voi do cao la 1
        res[index] = total + w[index];
        nex[pre[index]] = nex[index];
        pre[nex[index]] = pre[index];
        // neu chieu cao cai sau lon hon cai truoc
        if(h[nex[index]]<h[pre[index]])
        {
            w[nex[index]] += w[index];
            total += (w[index] * (h[nex[index]] - h[index])); // do day vi tri index
            index = nex[index];
            // tim vi tri nuoc tran
            while(h[nex[index]] < h[index]) index = nex[index];
        }
        else
        {
            w[pre[index]] += w[index];
			total += ((h[pre[index]] - h[index]) * w[index]);
			index = pre[index];
			while(h[pre[index]] < h[index]) index = pre[index];
        }
    }
    for(ll i=1;i<=n;i++) cout<<res[i]<<endl;
}