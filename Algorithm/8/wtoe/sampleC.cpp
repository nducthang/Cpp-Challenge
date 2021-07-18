/*************************************************************************
Program     :   DI CHUYEN TU TAY SANG DONG (WTOE)
Date        :   13-3-2007
Group       :   Qui hoach dong
Langues     :   Dev C++
*************************************************************************/

#include <fstream.h>

#define tfi "WTOE.INP"
#define tfo "WTOE.OUT"

// Khai bao luong input, output
ifstream inp;
ofstream out;

// Khai bao cac hang so
const int MAXN=102;
const long VC=2000000000;

// Khai bao cac bien chinh
int n, m, a[MAXN][MAXN], x[MAXN];
long f[MAXN][MAXN];

// Ham doc du lieu
int doc()
{
    int i,j;
    inp.open(tfi);
    inp >> m >> n;
    for (i=1; i<=m; i++)
        for (j=1; j<=n; j++) inp >> a[i][j];
    inp.close();
}

// Ham tinh gia tri nho nhat
long min(long u, long v, long w)
{
    long kq=u;
    if (kq>v) kq=v;
    if (kq>w) kq=w;
    return kq;
}

// Ham tinh bang qui hoah
int TinhF()
{
    int i,j;
    for (j=1; j<=n; j++) {f[0][j]=VC; f[m+1][j]=VC;}
    for (i=1; i<=m; i++) f[i][1]=a[i][1];
    for (j=2; j<=n; j++)
        for (i=1; i<=m; i++) 
            f[i][j]=min(f[i-1][j-1],f[i][j-1],f[i+1][j-1])+a[i][j];
    int u=1;
    for (i=2; i<=m; i++)
        if (f[i][n]<f[u][n]) u=i;
    return u;
}

// Ham Tim lai duong di
int TimNguoc(int u)
{
    int i;
    for (i=n; i>=1; i--)
    {
        x[i]=u;
        if (f[u][i]==f[u-1][i-1]+a[u][i]) u--; else
           if (f[u][i]==f[u+1][i-1]+a[u][i]) u++;
    }
}


// Ham in ket qua
int viet()
{
    int i;
    out.open(tfo);
    out << f[x[n]][n] << '\n';
    for (i=1; i<=n; i++) out << x[i] << ' ';
    out.close();
}
// CHUONG TRINH CHINH
int main()
{
    doc();
    TimNguoc(TinhF());
    viet();
}
