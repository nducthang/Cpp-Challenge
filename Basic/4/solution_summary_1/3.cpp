#include <iostream>
#include <cmath>
using namespace std;

int main()
{
    int n;
    cin>>n;
    float S=0;
    for(int i=n;i>=1;i--)
        S=sqrt(i+S);
    cout<<S<<endl;
}