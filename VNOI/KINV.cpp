/*
F[i][j]: số lượng dãy nghịch thế độ dài i bắt đầu từ j
Tính F[i][j] thông qua F[i-1][jx] với jx từ 1 đến j thỏa mãn A[jx] > A[j]
*/
#include <iostream>
using namespace std;
#define MAX 10002
int n,k;
int a[MAX];
int F[MAX][MAX];
int bit[MAX];
int base =1000000000;
void Enter()
{
    cin>>n>>k;
    for(int i=1;i<=n;i++) cin >> a[i];
}
int SearchBit(int i)
{
    int res = 0;
    while (i>0)
    {
        res = (res + bit[i]) % base;
        i -= (i & (-i) );
    }
    return res;
    
}
void UpdateBit(int i, int v)
{
    while(i<MAX){
        bit[i] = (bit[i] + v) % base;
        i+= (i & (-i));
    }
}
void QHD()
{
    // so luong day nghich the do dai 1 bat dau tu j
    for(int j=1;j<=n;j++) F[1][j] = 1;
    for(int i=2;i<=k;i++)
    {
        for(int j=1;j<=n;j++) bit[j] = 0;
        for(int j=n;j>=1;j--)
        {
            F[i][j] = SearchBit(a[j]-1);
            UpdateBit(a[j], F[i-1][j]);
        }
    }
}
void Print()
{
    int res = 0;
    for(int i=1;i<=n;i++) res = (res +  F[k][i]) % base;
    cout<<res<<endl;
}
int main()
{
    Enter();
    QHD();
    Print();

}