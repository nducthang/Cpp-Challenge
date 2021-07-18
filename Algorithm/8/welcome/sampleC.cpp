/*************************************************************************
Program     :   KHACH SOP (WELCOME)
Date        :   22-3-2007
Group       :   Qui hoach dong
Langues     :   C++
*************************************************************************/

#include <fstream.h>
#define tfi "WELCOME.INP"
#define tfo "WELCOME.OUT"

// Khai bao luong inpu, outpu
ifstream inp;
ofstream out;

// Khai bao cac hang so
const int MAXN = 202;

// Khai bao cac bien chinh
int n, t[MAXN], s[MAXN], p[MAXN];
long ds, x[MAXN];

// Ham doc du lieu
int doc()
{
    int i;
    inp.open(tfi);
    inp >> n;
    for (i=1; i<=n; i++) inp >> t[i] >> s[i] >> p[i];
    inp.close();
}    

// Ham tinh tong tien lon nhat
int tinh()
{
    int i,j,tg;
    for (i=1; i<=n; i++)
       for (j=i+1; j<=n; j++)
           if (t[i]>t[j])
               {
                   tg=t[i]; t[i]=t[j]; t[j]=tg;
                   tg=s[i]; s[i]=s[j]; s[j]=tg;
                   tg=p[i]; p[i]=p[j]; p[j]=tg;
               }
    x[0]=0;
    for (i=1; i<=n; i++)
       for (j=i-1; j>=0; j--) if (abs(s[i]-s[j])<=abs(t[i]-t[j]))
           if (x[i]<x[j]+p[i]) x[i]=x[j]+p[i];
    ds=0;
    for (i=1; i<=n; i++) if (ds<x[i]) ds=x[i];
}    

// Ham viet
int viet()
{
    out.open(tfo);
    out << ds << '\n';
    out.close();
}
// CHUONG TRINH CHINH
int main()
{
    doc();
    tinh();
    viet();
}
