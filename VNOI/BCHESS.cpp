#include <iostream>
#include <algorithm>
using namespace std;
#define MAX 2002
int n;
char a[MAX][MAX];

int f1a[MAX][MAX], f1b[MAX][MAX], f2[MAX][MAX], f3[MAX][MAX];
int res1, res2, res3;
int c1, c2, c3;

void Input()
{
    cin>>n;
    for(int i=1;i<=n;i++)
        for(int j=1;j<=n;j++)
            cin>>a[i][j];

}
void Init()
{
    // khoi tao
    for(int j=1;j<=n;j++)
    {
        if(a[1][j]=='0'){
            f2[1][j] = 0;
            f3[1][j] = 1;
            res3 = 1;
        }
        else{
            f2[1][j] = 1;
            f3[1][j] = 0;
            res2 = 1;
        }
        f1a[1][j] = 0;
        f1b[1][j] = 0;
    }

    for(int i=1;i<=n;i++)
    {
        if(a[i][1]=='0'){
            f2[i][1] = 0;
            f3[i][1] = 1;
            res3 = 1;
        }
        else{
            f2[i][1] = 1;
            f3[i][1] = 0;
            res2 = 1;
        }
        f1a[i][1] = 0;
        f1b[i][1] = 0;
    }
    
}
int min3(int a, int b,int c)
{
    return min(min(a,b),c);
}
void Process()
{
    for(int i=1;i<=n;i++)
    {
        for(int j=1;j<=n;j++)
        {
            if(a[i][j] == a[i-1][j-1] &&  a[i-1][j]==a[i][j-1])
            {
                if(a[i][j]=='0')
                {
                    f1a[i][j] = min3(f2[i][j-1], f2[i-1][j], f3[i-1][j-1]) + 1;
                    f1b[i][j] = 0;
                    f2[i][j] = 0;
                    f3[i][j] = min3(f1b[i][j-1], f1b[i-1][j], f1a[i-1][j-1]) + 1;
                }
                else
                {
                    f1a[i][j] = 0;
                    f1b[i][j] = min3(f3[i][j-1], f3[i-1][j], f2[i-1][j-1]) + 1;
                    f2[i][j] = min3(f1a[i][j-1], f1a[i-1][j], f1b[i-1][j-1]) + 1;
                    f3[i][j] = 0;
                }
            }
            else
            {
                if(a[i][j]=='0') f3[i][j] = 1;
                else f2[i][j] = 1;
            }
        }
    }
}
void Print()
{
    for(int i=1;i<=n;i++)
    {
        for(int j=1;j<=n;j++)
        {
            res1 = max(res1, max(f1a[i][j], f1b[i][j]));
            res2 = max(res2, f2[i][j]);
            res3 = max(res3, f3[i][j]);
        }
    }
    for(int i=1;i<=n;i++)
    {
        for(int j=1;j<=n;j++)
        {
            if(a[i][j] == '0')
            {
                if(res1 > 0 && f1a[i][j]==res1) c1++;
                if(res3 > 0 && f3[i][j]==res3) c3++;
            }
            else
            {
                if(res1 > 0 && f1b[i][j]==res1) c1++;
                if(res2 > 0 && f2[i][j]==res2) c2++;
            }
        }
    }
    cout<<res1<<" "<<c1<<endl;
    cout<<res2<<" "<<c2<<endl;
    cout<<res3<<" "<<c3<<endl;
}
int main()
{
    Input();
    Init();
    Process();
    Print();
}