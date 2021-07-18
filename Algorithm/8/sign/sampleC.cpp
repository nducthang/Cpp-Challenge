/*************************************************************************
Program    :   DIEN DAU CONG TRU (SIGN)
Date       :   14-3-2007
Group      :   Qui hoach dong
Langues    :   Dev C++
*************************************************************************/

#include <fstream.h>
#define tfi "SIGN.INP"
#define tfo "SIGN.OUT"

// Khai bao luong input, output
ifstream inp;
ofstream out;

// Khai bao cac hang so
const int MAXN = 102;
const int MAXK = 10002;

// Khai bao cac bien chinh
int s, n, k, m, a[MAXN], dd[MAXK], x[MAXN];

// Ham doc du lieu
int doc()
{
    int i;
    inp.open(tfi);
    inp >> n >> k;
    for (i=1; i<=n; i++) inp >> a[i];
    inp.close();
}    

// Ham xay dung bang qui hoach dong
int xdb()
{
    int i, j, max;
    s=0;
    for (i=1; i<=n; i++) s+=a[i];
    if (k<2*a[1]-s) return 1; 
    m=s+k-2*a[1];
    for (i=0; i<=m; i++) dd[i]=0;
    dd[0]=-1;
    max=0;
    for (i=2; i<=n; i++)
    {
        for (j=max; j>=0; j--)
            if ((dd[j]!=0) && (j+2*a[i]<=m) && (dd[j+2*a[i]]==0))
            {
                dd[j+2*a[i]]=i; 
                if (j+2*a[i]>max) max=j+2*a[i];
            }
    }
    return 0;
}    

// Ham xu li bang qui hoach dong
int xlb()
{
    int u, i;
    if (dd[m]==0) return 1;
    u=m;
    for (i=1; i<=n; i++) x[i]=0;
    while (u>0)
    {
       x[dd[u]]=1;
       u-=2*a[dd[u]];
    }
    return 0;
}    

// Ham in ket qua
int viet()
{
    int i;
    out.open(tfo);
    if ((dd[m]==0) || (k<2*a[1]-s)) out << '0' ; else
    {
        out << '1';
        for (i=2; i<=n; i++)
            if (x[i]!=0) out << '+'; else out << '-';
    }
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
