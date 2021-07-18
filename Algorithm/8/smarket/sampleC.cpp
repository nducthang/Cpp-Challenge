/*************************************************************************
Program     :   SIEU THI (SMARKET)
Date        :   27-3-2007
Group       :   Qui hoach dong
Langues     :   Dev C++
*************************************************************************/

#include <fstream.h>
#define tfi "SMARKET.INP"
#define tfo "SMARKET.OUT"

// Khai bao luong input, output
ifstream inp;
ofstream out;

// Dinh nghia hang so
const int MAXS=1002;
const int MAXN=502;

// Khai bao cac bien chinh
int s, n, c[MAXN], m[MAXN], d[MAXS];
long f[MAXS], ds, x[MAXN];

// Ham doc du lieu
int doc()
{
    int i;
    inp.open(tfi);
    inp >> s >> n;
    for (i=1; i<=n; i++) inp >> c[i] >> m[i];
    inp.close();
    return 0;
}

// Ham tinh
int tinh()
{
    int i,k,l;
    f[0]=1;
    for (i=1; i<=n; i++)
        for (k=s; k>=0; k--)
            for (l=1; ((l<=m[i]) && (k-l*c[i]>=0));l++)
                {f[k]+=f[k-l*c[i]]; f[k]%=131131;}
    return f[s];
}    

// Ham tim mot phuong an
int tim()
{
    int max=0, i, l, j;
    d[0]=-1; 
    for (i=1; i<=n; i++)
        for (l=1; l<=m[i]; l++)
            for (j=max; j>=0; j--)
                if ((d[j]!=0) && (j+c[i]<=s))
                {
                    if (d[j+c[i]]==0) d[j+c[i]]=i;
                    if (j+c[i]>max) max=j+c[i];
                    if (max==s) goto l1;
                }
    l1:
    int u;
    for (u=s; u>0; u-=c[d[u]]) x[d[u]]++;
}

// Ham in ket qua
int viet()
{
    out.open(tfo);
    out << ds << '\n';
    for (int i=1; i<=n; i++) out << x[i] << ' ';
    out << '\n';
    out.close();
}

// CHUONG TRINH CHINH
int main()
{
    doc();
    ds=tinh();
    if (ds!=0) tim();
    viet();
}
