#include <iostream>
#include <sstream>
using namespace std;

int main()
{
    int t;
    string s, word;
    cin>>t;
    getline(cin,s);
    for(int i=1;i<=t;i++)
    {
        getline(cin,s);
        stringstream ss(s);
        int pLen = 0, count = 0, result = 0;
        while(ss>>word)
        {
            int len = word.size();
            if(len==pLen) count++;
            else 
            {
                if(count>result) result = count;
                count = 1;
                pLen = len;
            }
        }
        if(count>result) result = count;
        cout<<result<<endl;
    }
}