#include <iostream>
using namespace std;

int main()
{
    int s;
    cin>>s;
    int h = s/3600;
    int m = (s-h*3600)/60;
    s = s - h*3600 - m*60;
    if(h>=13)
        cout<< h%12 <<":"<<m<<":"<<s<<" PM"<<endl;
    else
        cout << h <<":"<<m<<":"<<s<<" AM"<<endl;
}