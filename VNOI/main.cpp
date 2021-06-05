#include <iostream>
#include <string>
#include <stack>
using namespace std;

int main()
{
    stack<char> str;
    string s;
    cin>>s;
    for(int i=0;i<s.length();i++)
    {
        // Đưa string vào stack
        str.push(s[i]);
    }
    // Duyệt stack
    int res=0;
    while(str.size()>0)
    {
        char c = str.top();
        str.pop();
        if(c=='C') res+=12;
        else if(c=='H') res+=1;
        else if(c=='O') res+=16;
        else
        {
            int number = c - 48;
            int temp=0;
            char c_temp = str.top();
            str.pop();
            if(c_temp!=')')
            {
                char c2 = str.top();
                str.pop();
                if(c=='C') res+=12*number;
                else if(c=='H') res+=1*number;
                else if(c=='O') res+=16*number;
            }
            else
            {
                while(str.top()=='(')
                {
                    char c2=str.top();
                    str.pop();
                    if(c=='C') temp+=12;
                    else if(c=='H') temp+=1;
                    else if(c=='O') temp+=16;
                }
                str.pop(); // lay dau ( ra
                res += number*temp;
            }
        }
    }
    cout<<res;
}
