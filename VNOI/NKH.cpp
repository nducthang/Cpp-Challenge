#include <iostream>
using namespace std;
string s1, s2, s;
char x[202]; // luu kq
int len;
void Try(int k, int i, int j)
{
    // k: vi tri dang xet chuoi S
    // i: vi tri dang xet S1
    // j: vi tri dang xet S2
    if(k>len){
        // in ra
        for(int i=1;i<=len;i++) cout<<x[i];
        cout<<endl;
        exit(0);
        // return;
    }
    if(s[k] == s1[i])
    {
        x[k] = '1';
        Try(k+1,i+1,j);
    }
    if(s[k] == s2[j])
    {
        x[k] = '2';
        Try(k+1, i, j+1);
    }
}
int main()
{
    cin>>s1>>s2>>s;
    len = s.length();
    s1 = " " + s1;
    s2 = " " + s2;
    s = " " + s;
    Try(1,1,1);
}