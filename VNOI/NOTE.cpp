#include <iostream>
using namespace std;
int cal(int f, int p)
{
    // U = 1, D = 0
    if(f==1) return 0;
    if(p%4==1) return 1;
    if(p%4==3) return 0;
    return cal(f-1, p/2);
}
int main()
{
    int f,p;
    while(cin>>f>>p)
    {
        if(f==0 && p==0) break;
        if(cal(f,p)) cout<<"U"<<endl;
        else cout<<"D"<<endl;
    }
}