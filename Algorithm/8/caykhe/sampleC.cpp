/*************************************************************************
Program     :    TUI BA GANG (CAYKHE)
Date        :    13-3-2007
Group       :    Qui hoach dong
Langues     :    Dev C++
*************************************************************************/

#include <fstream.h>

#define tfi "CAYKHE.INP"
#define tfo "CAYKHE.OUT"

// Khai bao luong input, output
ifstream inp;
ofstream out;

// Khai bao cac hang so
const int MAXN = 102;

// Cac bien chinh
int n, m, a[MAXN], b[MAXN], f[MAXN][MAXN], x[MAXN];


// Ham doc du lieu
int doc()
{
    int i;
    inp.open(tfi);
    inp >> n >> m;
    for (i=1; i<=n; i++) inp >> a[i] >> b[i];
    inp.close();
}

// Ham xay dung bang qui hoach dong
int xdb()
{
    int i,j;
    for (j=0; j<=m; j++) f[0][j]=0;
    for (i=1; i<=n; i++)
    {
        f[i][0]=0;
        for (j=1; j<=m; j++)
        {
            f[i][j]=f[i-1][j];
            if ((j>=b[i]) && (f[i][j]<f[i-1][j-b[i]]+a[i]))
                f[i][j]=f[i-1][j-b[i]]+a[i];
        }
    }
}

// Ham xu ly bang qui hoach dong
int xlb()
{
    int u,v;
    v=m;
    for (u=n; u>=1; u--)
    {
        x[u]=0;
        if (f[u][v]==f[u-1][v-b[u]]+a[u]) {x[u]=1; v=v-b[u];}
    }
}

// Ham in ket qua
int viet()
{
    int i, slx=0;
    for (i=1; i<=n; i++) slx+=x[i];
    out.open(tfo);
    out << f[n][m] << '\n';
    out << slx << ' ';
    for (i=1; i<=n; i++)
        if (x[i]!=0) out << i << ' ';
    out << '\n';
    out.close();
}

// CHUONG TRINH CHINH
int main()
{
    doc();
    xdb();
    xlb();
    viet();
}
