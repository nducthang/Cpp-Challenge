#include <iostream>
#include <cmath>
using namespace std;

int main()
{
    int n;
    cin>>n;
    int sum=0;
    for(int i=1;i<n;++i)
        if(n%i==0)
            sum+=i;

    if(sum>n)
        cout<<n<<" la so thinh vuong"<<endl;
    else
        cout<<n<<" khong la so thinh vuong"<<endl;
}