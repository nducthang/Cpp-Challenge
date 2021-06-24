#include <iostream>
#include <cmath>
using namespace std;

int main()
{
    int t;
    int x,y;
    cin>>t;
    for(int i=1;i<=t;i++)
    {
        cin>>x>>y;
        int dis = abs(y-x);
        int len = 0, idx = 0, step = 0;
        while(len < dis){
            len += (idx+1)/2;
            idx++;
            step++;
        }
        if(dis != 0) step--;
        cout<<step<<endl;
    }
}