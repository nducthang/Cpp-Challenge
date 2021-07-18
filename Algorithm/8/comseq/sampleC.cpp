/*************************************************************************
Program    :    DAY CON CHUNG DAI NHAT CUA HAI DAY SO
Date       :    13-3-2007
Group      :    Qui hoach dong
Langues    :    Dev C++
*************************************************************************/

#include <fstream.h>

#define tfi "COMSEQ.INP"
#define tfo "COMSEQ.OUT"

// Khai bao luong input, output
ifstream inp;
ofstream out;

// Khai bao cac hang so
const int MAXN = 102;

// Khai bao cac bien chinh
int n, m, k, a[MAXN], b[MAXN],c[MAXN], ca[MAXN], cb[MAXN], f[MAXN][MAXN];

// Ham doc du lieu
int doc()
{
    int i;
    inp.open(tfi);
    inp >> m >> n;
    for (i=1; i<=m; i++) inp >> a[i];
    for (i=1; i<=n; i++) inp >> b[i];
    inp.close();
}

// Ham tim gia tri lon nhat cua ba so
int max(int u, int v, int w)
{
    int kq=u;
    if (kq<v) kq=v;
    if (kq<w) kq=w;
    return kq;
}

// Ham tinh bang qui hoach dong
int TinhF()
{
    int i,j;
    for (j=0; j<=n; j++) f[0][j]=0;
    for (i=1; i<=m; i++)
    {
        f[i][0]=0;
        for (j=1; j<=n; j++)
            if (a[i]==b[j]) f[i][j]=f[i-1][j-1]+1; else
                f[i][j]=max(f[i-1][j],f[i][j-1],f[i-1][j-1]);
    }
    return f[m][n];
}

// Ham xay dung lai day ban dau
int TimNguoc()
{
    int i,u,v;
    u=m; v=n;
    for (i=k; i>=1; i--)
    {
        while (a[u]!=b[v])
           if (f[u][v]==f[u-1][v]) u--; else
               if (f[u][v]==f[u][v-1]) v--; else {u--; v--;}
        c[i]=a[u];
        ca[i]=u--;
        cb[i]=v--;
    }
}

// Ham viet ket qua
int viet()
{
    int i;
    out.open(tfo);
    out << k << '\n';
    if (k>0)
    {
        for (i=1; i<=k; i++) out << c[i] << ' '; out << '\n';
        for (i=1; i<=k; i++) out << ca[i] << ' '; out << '\n';
        for (i=1; i<=k; i++) out << cb[i] << ' '; // out << '\n';
    }
    out.close();
}

// Ham chinh
int solve()
{
    k=TinhF();
    if (k>0) TimNguoc();
}

// CHUONG TRINH CHINH
int main()
{
    doc();
    solve();
    viet();
}
