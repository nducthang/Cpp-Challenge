#include <iostream>
using namespace std;

int main()
{
    float x,n;
    cin>>x>>n;
    float sum=x;
    float tu=x, mau = 1;
    for(int i=1;i<=n;i++)
    {
        tu *= (x*x);
        mau *= (2*i+1)*(2*i);
        sum+=tu/mau;
    }
    cout<<sum<<endl;
}