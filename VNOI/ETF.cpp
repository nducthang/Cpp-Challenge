#include <iostream>
#include <cstring>
using namespace std;
#define MAX 1000001
typedef long long ll;
bool prime[MAX]; // F[i] = true neu i la so nguyen to
ll f[MAX];
ll T,n;
void SangNguyenTo()
{
    memset(prime,1,sizeof(prime));
    for(ll i=2; i*i<MAX; i++){
        if(prime[i]){
            for(ll j=i; i*j<MAX; j++){
                prime[i*j]=false;
            }
        }
    }
}
void CalcF()
{
    // Phi(x)=x*(p1-1)*(p2-2).... / (p1*p2...) voi p_i la so nguyen to
    // x = sum(p_i)
    for(int i=1; i < MAX; ++i) f[i] = i;
    for(int i=2; i < MAX; ++i){
        if(prime[i]){
            for(int j = i; j < MAX; j += i)
                f[j] = f[j] / i * (i-1);
        }
    }
}
int main()
{
    cin>>T;
    SangNguyenTo();
    CalcF();
    for(int i=1; i<=T; i++)
    {
        cin>>n;
        cout<<f[n]<<endl;
        //cout<<n-F[n]-1<<endl;
    }
}

