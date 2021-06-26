/*
F[i,j] là số xâu con đối xứng trong xâu S[i..j]
Nếu S[i] = S[j] thì F[i,j] = F[i+1, j] + F[i,j-1] + 1
o.w F[i,j] = F[i+1,j] + F[i,j-1] - F[i+1,j-1]

Luu y: Code xu ly so lon
*/

#include <iostream>
using namespace std;
string s;
#define MAX 122
string F[MAX][MAX];
// Xu ly so lon
// cong 2 so lon
string add(string a, string b)
{
    while(a.length()<b.length()) a = '0' + a;
    while(b.length()<a.length()) b = '0' + b;
    string res = "";
    int carry = 0;
    for(int i=a.length()-1;i>=0;i--)
    {
        int x = a[i] - '0', y = b[i] - '0';
        int sum = x+y+carry;
        carry = sum / 10;
        res =  (char)(sum % 10 + '0') + res;
    }
    if(carry) res = '1' + res;
    return res;
}
// tru 2 so lon
string sub(string a, string b)
{
    while(a.length()<b.length()) a = '0' + a;
    while(a.length()>b.length()) b = '0' + b;
    string res = "";
    int borrow = 0;
    for(int i=a.length()-1;i>=0;i--)
    {
        int x = a[i] - '0', y = b[i] - '0';
        int diff =  x - y - borrow;
        if(diff<0) {
            diff += 10;
            borrow = 1;
        }
        else{
            borrow = 0;
        }
        res = (char)(diff+'0') + res;
    }
    return res; 
}
int main()
{
    cin>>s;
    int n = s.length();
    s = " " + s;
    // Quy hoach dong
    for(int i=1;i<=n;i++) F[i][i] = "1";
    for(int i=2;i<=n;i++) F[i][i-1] = "0";
    for(int k=1;k<=n-1;k++)
    {
        for(int i=1;i<=n-k;i++)
        {
            int j = i+k;
            if(s[i]==s[j]) F[i][j] = add(add(F[i+1][j],F[i][j-1]), "1");
            else F[i][j] = sub(add(F[i+1][j],F[i][j-1]),F[i+1][j-1]);
        }
    }
    // Xu ly tiep
    while(F[1][n][0] == '0') F[1][n].erase(0, 1);
    cout<<F[1][n]<<endl;
}